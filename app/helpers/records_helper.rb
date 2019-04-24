module RecordsHelper
  def html_safe_citation_for(record)
    record.collect_citation_attributes.collect{ |attribute|
      content_tag(:p, attribute) unless attribute.blank? }.join.html_safe
  end

  # Returns a set of printable records
  def printable_records(records, print_format)
    @printable_records ||=
      records.collect{ |record| printable_record(record, print_format) }
  end

  # Returns a printable record
  def printable_record(record, print_format)
    # Send the record, view_context and print format
    RecordDecorator.print(record, self, print_format)
  end

  def select_title
    check_box_tag(:select)
  end

  # Returns an Array of select options as HTML links
  #   - all
  #   - none
  def select_options
    [ link_to(t('record.select.all'), records_path, class: "select-all"),
      link_to(t('record.select.none'), records_path, class: "select-none") ]
  end

  # Returns an Array of email options as HTML links
  def email_options
    email_options_collection.collect do |email_format|
      link_to(email_format[0], new_email_records_path(email_format[1].to_sym),
        {class: "email", data: {toggle: "modal", target: "#modal"}})
    end
  end

  # Returns an Array of email options for select box
  def email_options_for_select
    options_for_select(email_options_collection)
  end

  # Returns a collection of email options as tuples
  def email_options_collection
    RecordsController::WHITELISTED_EMAIL_FORMATS.collect do |email_format|
      [t("record.collection.email.options.#{email_format}"), email_format]
    end
  end

  # Returns an Array of print options as HTML links
  def print_options
    RecordsController::WHITELISTED_PRINT_FORMATS.collect do |print_format|
      link_to(t("record.collection.print.options.#{print_format}"),
        print_records_path(print_format.to_sym), class: :print, target: :_blank)
    end
  end

  # Returns an Array of export options as HTML links
  #   - RefWorks
  #   - EndNote
  #   - RIS
  #   - BibTex
  def export_options
    [ link_to(t('record.collection.export.options.refworks'), cite_path("refworks"), id: :refworks, target: :_blank),
      link_to(t('record.collection.export.options.endnote'), cite_path("endnote"), id: :endnote, target: :_blank),
      link_to(t('record.collection.export.options.ris'), cite_path("ris"), id: :ris, target: :_blank),
      link_to(t('record.collection.export.options.bibtex'), cite_path("bibtex"), id: :bibtex, target: :_blank) ]
  end

  def cite_path(format)
    institution = current_user&.institution_code || 'NYU'
    return Eshelf::Citation.cite_url(format: format, institution: institution)
  end

  # Returns an Array of 'per page' pagination options as HTML links
  #   - 10
  #   - 20
  #   - 50
  #   - 100
  def per_page_options
    [ link_to(10, records_path(current_filters.merge(per: 10))),
      link_to(20, records_path(current_filters.merge(per: 20))),
      link_to(50, records_path(current_filters.merge(per: 50))),
      link_to(100, records_path(current_filters.merge(per: 100)))]
  end

  # Returns an Array of sort options as HTML links
  #   - Created at
  #   - Title
  #   - Author
  def sort_options
    [ 
      link_to(t('record.collection.sort.options.created_at'), records_path(current_filters.merge(sort: sort_param("created_at"))), class: "sorted#{sort_direction_class("created_at")}"),
      link_to(t('record.collection.sort.options.title_sort'), records_path(current_filters.merge(sort: sort_param("title_sort"))), class: "sorted#{sort_direction_class("title_sort")}"),
      link_to(t('record.collection.sort.options.author'), records_path(current_filters.merge(sort: sort_param("author"))), class: "sorted#{sort_direction_class("author")}")
    ]
  end

  def sort_direction_class(sort_field)
    if sort_field == parsed_current_sort.first
      " #{parsed_current_sort.last}"
    end
  end

  def current_sort_label
    @current_sort_label ||= t("record.collection.sort.options.#{parsed_current_sort.first}").html_safe
  end

  def parsed_current_sort
    @parsed_current_sort ||= (filter_params[:sort].present?) ? filter_params[:sort].split(/(.+)_(desc|asc)/) - ["", nil] : ["created_at", "asc"]
  end

  def sort_param(sort_field)
    sort_param = "#{sort_field}_"
    current_sort_field = parsed_current_sort.first
    current_sort_direction = parsed_current_sort.last
    if sort_field == current_sort_field
      sort_param += switch_sort_direction(current_sort_direction)
    else
      sort_param += "asc"
    end
    sort_param
  end

  def switch_sort_direction(direction)
    (direction == "asc") ? "desc" : "asc"
  end
  protected :switch_sort_direction

  # Returns a Hash of the currently applied filters
  #   - content type
  #   - tag
  #   - id
  #   - external_system
  #   - external_id
  #   - sort
  #   - page
  #   - per
  def current_filters
    { content_type: filter_params[:content_type], tag: filter_params[:tag], id: filter_params[:id],
      external_system: filter_params[:external_system], external_id: filter_params[:external_id],
      sort: filter_params[:sort], page: filter_params[:page], per: filter_params[:per] }
  end
  protected :current_filters

  def filter_params
    params.permit(:page, :content_type, :tag, :external_system, :external_id, :sort, :per, :id, id: [])
  end
end
