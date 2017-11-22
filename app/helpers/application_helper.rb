module ApplicationHelper

  # ILL URL for the current institution
  def ill_url
    @ill_url ||= ill["url"] unless ill.blank?
  end

  # ILL entry for the current institution
  def ill
    @ill ||= current_primary_institution.views["ill"]
  end

  # Eshelf workspace header
  def eshelf_header
    content_tag(:h2, class: "workspace") do
      content_tag(:span, "#{t('workspace.header_html')} ")
    end
  end

end
