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
  #   - EasyBib
  #   - RIS
  #   - BibText
  def export_options
    [ link_to(t('record.collection.export.options.refworks'), ex_cite.export_citations_path("refworks"), id: :refworks, target: :_blank),
      link_to(t('record.collection.export.options.endnote'), ex_cite.export_citations_path("endnote"), id: :endnote, target: :_blank),
      link_to(t('record.collection.export.options.easybib'), ex_cite.export_citations_path("easybibpush"), id: :easybib, target: :_blank),
      link_to(t('record.collection.export.options.ris'), records_path(:ris), id: :ris, target: :_blank),
      link_to(t('record.collection.export.options.bibtex'), records_path(:bibtex), id: :bibtex, target: :_blank) ]
  end

  # Returns an Array of 'per page' pagination options as HTML links
  #   - 10
  #   - 20
  #   - 50
  #   - 100
  def per_page_options
    [ link_to(10, records_path({per: 10}.merge current_filters)),
      link_to(20, records_path({per: 20}.merge current_filters)),
      link_to(50, records_path({per: 50}.merge current_filters)),
      link_to(100, records_path({per: 100}.merge current_filters)) ]
  end

  # Returns an Array of sort options as HTML links
  #   - Created at
  #   - Title
  #   - Author
  def sort_options
    [ link_to_sorted(t('record.collection.sort.options.created_at'), :created_at),
      link_to_sorted(t('record.collection.sort.options.title_sort'), :title_sort),
      link_to_sorted(t('record.collection.sort.options.author'), :author) ]
  end

  def current_sort_label
    @current_sort_label ||= t("record.collection.sort.options.#{parsed_current_sort.first}").html_safe
  end

  def parsed_current_sort
    @parsed_current_sort ||= Sorted::Parser.new(current_sort).parse_sort.first
  end

  # Returns a Hash of the currently applied filters
  #   - content type
  #   - tag
  #   - id
  #   - external_system
  #   - external_id
  #   - sort
  def current_filters
    { content_type: params[:content_type], tag: params[:tag], id: params[:id],
      external_system: params[:external_system], external_id: params[:external_id],
      sort: params[:sort] }
  end
  protected :current_filters
end
