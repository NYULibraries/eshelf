module Eshelf
  class Citation
    attr_accessor :external_id

    @@cite_url = ENV['CITE_URL'] || 'https://cite-dev.library.nyu.edu/'

    def self.cite_url(format:, institution: 'NYU', calling_system: 'primo', cite_url: @@cite_url)
      return "#{cite_url}?calling_system=#{calling_system}&institution=#{institution}&cite_to=#{format}"
    end

    def initialize(external_id)
      @external_id = external_id
    end

    def to_json
      @to_json ||= get_citation&.body
    end

    def openurl
      @openurl ||= JSON.parse(get_openurl)&.send(:[],"openurl") if get_openurl && get_openurl.headers[:content_type] == 'application/json'
    end

  private

    def get_citation
      @get_citation ||= RestClient.get(Citation.cite_url(format: 'json'), params: { external_id: external_id })
    rescue RestClient::ExceptionWithResponse => e
      nil
    end

    def get_openurl
      @get_openurl ||= RestClient.get(Citation.cite_url(format: 'json', cite_url: "#{@@cite_url}openurl/#{external_id}"))
    rescue RestClient::ExceptionWithResponse => e
      nil
    end
  end
end
