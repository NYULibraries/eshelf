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

  def deselect_filter(filter, selected_filter)
    content_tag(:span, link_to(fa_icon(:times), records_url), class: 'deselect_filter') if filter.eql?(selected_filter)
  end

  def content_type_tag(content_type)
    raise ArgumentError, "content_type must be a string" unless content_type.is_a? String
    content_type = 'database' if content_type == 'document'
    content_tag(:figure, class: "content-type") do
      fa_icon(content_type_to_fa_icon(content_type)) +
        content_tag(:figcaption, content_type.capitalize.tr("_", " "))
    end
  end
    
 protected

  def content_type_to_fa_icon(content_type)
    content_type = content_type.downcase.to_sym
    return font_awesome_mapping[content_type]    
  end

  def font_awesome_mapping
    {
      archives: 'archive',
      article: 'bookmark',
      audio: 'volume-up',
      book: 'book',
      database: 'database',
      dataset: 'table',
      essay: 'file-text',
      image: 'file-image-o',
      journal: 'file-text-o',
      map: 'map',
      newspaper: 'newspaper-o',
      score: 'music',
      text: 'file-text',
      unknown: 'question-circle',
      video: 'video-camera',
      conference_paper: 'file-text',
      conference_proceedings: 'file-text',
      dissertation: 'file-text',
      thesis: 'file-text',
      working_paper: 'file-text',
    }
  end

  def cite_path(format)
    institution = current_user&.institution_code || 'NYU'
    return Eshelf::Citation.cite_url(format: format, institution: institution)
  end

 end
