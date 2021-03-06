# The records controller manages a user's set of saved record,
# and offers a set of actions:
#   - :index - display a paginated list of user records optionally filtered
#     by content type, tag and/or id as html, json, xml, ris or bibtex
#   - :show - show a given record as html, json, xml, ris or bibtex
#   - :from_external_system - display a paginated list of user records from a given
#     external system optionally filtered by external id as html, json, xml, ris or bibtex
#   - :create - create a record via xml or json
#   - :update - update a records tags via html, xml or json
#   - :new_email - display an email form for sending selected records
#   - :create_email - send an email of selected records to the given email address
#   - :print - display a print friendly list of records
#   - :getit - redirect to a record's GetIt url
#
# Author::    scotdalton
# Copyright:: Copyright (c) 2013 New York University
# License::   Distributes under the same terms as Ruby
class RecordsController < ApplicationController
  API_ACTIONS = %w{ from_external_system create destroy }

  after_action :respond_with_csrf_header

  WHITELISTED_EMAIL_FORMATS = ["brief", "medium", "full"]
  WHITELISTED_PRINT_FORMATS = ["brief", "medium", "full"]

  respond_to :xml, :json
  respond_to :html, except: [:create]
  # respond_to :js, only: [:api]

  # Get the user's records, filtered by
  # whatever filters were given.
  def index
    # Get the user's records
    @records = user_records
    # Filter by the specified content type if given
    @records = @records.where(content_type: view_context.filter_params[:content_type]) if view_context.filter_params[:content_type]
    # Filter by the specified tag if given
    @records = @records.tagged_with(double_escape_quotes(view_context.filter_params[:tag])) if current_user && view_context.filter_params[:tag]
    # Get the selected id(s) if given
    @records = @records.where(id: params[:id]) if params[:id]
    # Get the relevant page unless all is specified
    @records = (view_context.filter_params[:per].eql? "all") ?
      @records.page(1).per(user_records.count) : @records.page(view_context.filter_params[:page]).per(view_context.filter_params[:per])
    respond_with(@records) unless performed?
  end

  # Show the record based on id
  def show
    @record = user_records.find(params[:id])
    respond_with(@record)
  end

  # Get the records by external system and external id(s).
  # TODO: probably unnecessary and can be merged with index.
  def from_external_system
    @records = user_records.where(external_system: from_external_system_params[:external_system])
    @records = @records.where(external_id: from_external_system_params[:external_id]) if from_external_system_params[:external_id]
    # Get the relevant page unless all is specified
    @records = (from_external_system_params[:per].eql? "all") ?
      @records.page(1).per(user_records.count) : @records.page(params[:page]).per(view_context.filter_params[:per])
    respond_with(@records) do |format|
      format.html { render :index }
    end
  end

  # API access to create a record
  def create
    # Create a new record from the params and make it become
    # an external system (e.g. Primo) object if possible
    # in order to kick off callbacks
    @record = user.records.new(record_params).becomes_external_system
    flash[:notice] = t('record.flash.actions.create.notice') if @record.save!
    # Need to specify location due to external system inheritance
    respond_with(@record, location: record_url(@record))
  end

  # Update the tags associated with a record
  def update
    @record = user_records.find(params[:id])
    current_user.tag(@record, with: double_escape_quotes(params[:record][:tag_list]), on: :tags)
    respond_with(@record)
  end

  # Destroy the user's record(s)
  # Routed from both member and collection calls
  def destroy
    @records = user_records.where(id: params[:id]).destroy_all if params[:id]
    if @records.blank? && params[:record]
      @records = [params[:record]].flatten.collect { |record|
        next unless (record[:external_system] && record[:external_id])
        user_records.where(external_system: record[:external_system], external_id: record[:external_id]).destroy_all
      }.compact.flatten
    end
    flash[:notice] = t('record.flash.actions.destroy.notice')
    respond_with(@records, location: records_url)
  end

  # Display a form to create a new email.
  def new_email
    @email_format = whitelist_email_format(params[:email_format])
    # Since we take id's from collection and member routes,
    # we force the id param to be an array (collection style)
    @records = user_records.find((params[:id].is_a? Array) ? params[:id] : [params[:id]])
    respond_with(@records)
  end

  # Create (send) a new email
  def create_email
    head :bad_request and return unless @email_format = whitelist_email_format(params[:email_format])
    @records = user_records.find(params[:id])
    RecordsMailer.records_email(user, @records, @email_format, params[:to_address]).deliver_now
    flash[:notice] = t('record.flash.actions.create_email.notice')
    respond_with(@records, location: records_url)
  end

  # Display a print friendly list of records
  def print
    head :bad_request and return unless @print_format = whitelist_print_format(params[:print_format])
    # Since we take id's from collection and member routes,
    # we force the id param to be an array (collection style)
    @records = user_records.find((params[:id].is_a? Array) ? params[:id] : [params[:id]])
    respond_with(@records, layout: "print")
  end

  # Redirects to the record's GetIt url
  def getit
    @record = Record.find(params[:id])
    head :bad_request and return if @record.nil?
    @record.rebuild_openurl!(current_primary_institution.code) if @record.expired?
    # If external system is primo and we have a primo_id, link to primo
    if has_primo_as_external_system? && @record.external_id && ENV['PERSISTENT_LINKER_URL']
      redirect_to "#{ENV['PERSISTENT_LINKER_URL']}#{@record.external_id}?institution=#{current_primary_institution.code.upcase}"
    else
      # Otherwise use getit
      redirect_to getit_url + strip_getit_prefix(@record.url)
    end
  end

 private

  def strip_getit_prefix(url)
    return url.gsub(/^https:\/\/(dev\.|qa\.)?getit\.library\.nyu\.edu\/resolve(\?)?/,'')
  end

  # Get's the institution's getit url if it exists
  def institution_getit_url
    current_primary_institution.getit_url if current_primary_institution.respond_to?(:getit_url)
  end

  # Checks to see if the external system is set to primo
  def has_primo_as_external_system?
    @record.external_system.eql?("primo")
  end

  def getit_url
    # Default to the regular GetIt url without specifying institution if URL
    # doesn't exist
    @getit_url ||= institution_getit_url || ENV['GETIT_DEFAULT_URL']
  end

  # Send back the CSRF token for trusted origins
  # that make json requests to approved API actions.
  def respond_with_csrf_header
    # Only return the authenticity token to approved origins.
    return unless request.headers['HTTP_ORIGIN'] && origin_is_whitelisted?
    # Only return the authenticity token for JSON requests to approved API actions
    if(API_ACTIONS.include?(action_name) && formats.include?(:json))
      response.headers['X-CSRF-Token'] = form_authenticity_token
    end
  end

  # Whitelist the candidate email format
  def whitelist_email_format(candidate)
    WHITELISTED_EMAIL_FORMATS.find{ |format| format == candidate }
  end

  # Whitelist the candidate print format
  def whitelist_print_format(candidate)
    WHITELISTED_PRINT_FORMATS.find{ |format| format == candidate }
  end

  def record_params
    params.require(:record).permit(:external_system, :external_id, :format,
      :data, :title, :author, :url, :title_sort, :content_type)
  end

  def from_external_system_params
    params.permit(:per, :format, :_, :external_id, :external_system, :institution)
  end

  # Whitelisted CORS origins
  def whitelisted_origins
    @whitelisted_origins ||= (Rails.configuration.eshelf_origins || [])
  end

  def origin_is_whitelisted?
    whitelisted_origins.any? {|origin| request.headers['HTTP_ORIGIN'].gsub(/https?:\/\//, '').match(origin) }
  end
end
