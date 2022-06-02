module UsersHelper
  # Return a link to records filtered by the given tag
  def link_to_tagged_records(tag)
    unless tag.name == t('record.tag_list.no_tags')
      link_to tag, records_url(tag: tag.name)
    else
      tag.name
    end
  end

  def aleph_account_url
    URI.escape("#{ENV['ALEPH_HTTPS_BASE_URL']}/F?func=bor-info")
  end

  def bobcat_account_url
    if current_primary_institution.code == 'NYUAD'
      return URI.escape("#{ENV['PRIMO_BASE_URL']}/primo-explore/account?vid=#{current_primary_institution.code}&section=overview")
    end
    URI.escape("#{ENV['PRIMO_BASE_URL']}/primo-explore/account?vid=NYU&section=overview")
  end
end
