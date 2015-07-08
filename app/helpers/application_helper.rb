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
      content_tag(:span, "#{t('workspace.header_html')} ") + eshelf_info
    end
  end

  # Eshelf workspace info link
  def eshelf_info
    link_to_workspace_info("http://library.nyu.edu/info/eshelf.html", "right")
  end
end
