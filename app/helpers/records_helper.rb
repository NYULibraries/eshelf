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

 protected

  def cite_path(format)
    institution = current_user&.institution_code || 'NYU'
    return Eshelf::Citation.cite_url(format: format, institution: institution)
  end

 end
