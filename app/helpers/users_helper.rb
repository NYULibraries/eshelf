module UsersHelper
  # Return a link to records filtered by the given tag
  def link_to_tagged_records(tag)
    link_to tag, records_url(tag: tag.name)
  end
  def aleph_account_url
    URI.escape("#{Exlibris::Aleph.config.base_url}/F?func=bor-info")
  end
end
