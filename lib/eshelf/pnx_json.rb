module Eshelf
  class PnxJson

    @@primo_base_url = ENV['PRIMO_BASE_URL'] || "http://bobcatdev.library.nyu.edu"
    @@getit_url_regex = /http(s)?:\/\/((dev|qa)\.)?getit.library.nyu.edu(.+)resolve\?/

    attr_accessor :primo_id, :institution, :openurl

    def initialize(primo_id, institution = 'NYU')
      @primo_id = primo_id
      @institution = institution
    end

    def parsed_json_record
      @parsed_json_record ||= JSON.parse(get_record.body)
    end

    def openurl
      @openurl ||= strip_absolute_link_resolver_path_from(lln10)
    end

   private

    def strip_absolute_link_resolver_path_from(link)
      link.sub(@@getit_url_regex, '') unless link.nil?
    end

    def lln10
      @lln10 ||= delivery_links.
                  try(:select) {|link| link["displayLabel"] === "lln10" }.
                  try(:first).
                  try(:[],"linkURL")
    end

    def delivery_links
      @delivery_links ||= parsed_json_record.
        try(:[], "delivery").
        try(:[], "link")
    end

    def get_record
      @get_record ||= RestClient.get("#{@@primo_base_url}/primo_library/libweb/webservices/rest/v1/pnxs/L/#{primo_id}", {params: {inst: institution}})
    end

  end
end
