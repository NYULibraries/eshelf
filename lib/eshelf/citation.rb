module Eshelf
  class Citation
    attr_accessor :external_id, :institution

    @@cite_url = ENV['CITE_URL'] || 'https://cite-dev.library.nyu.edu/'

    def self.cite_url(format:, institution: 'NYU', calling_system: 'primo', cite_url: @@cite_url)
      return "#{cite_url}?calling_system=#{calling_system}&institution=#{institution}&cite_to=#{format}"
    end

    def initialize(external_id, institution = 'NYU')
      @external_id = external_id
      @institution = institution
    end

    def to_json
      @to_json ||= get_citation&.body
    end

    def openurl
      @openurl ||= citation_json&.dig("links", "lln10")
    end

    def record
      @record ||= citation_json&.to_hash
    end

  private

    def citation_json
      @citation_json ||= JSON.parse(get_citation).dig(self.external_id) if get_citation&.headers && get_citation.headers[:content_type] == 'application/json'
    end

    def get_citation
      @get_citation ||= RestClient.get(Citation.cite_url(format: 'json') + "&external_id[]=#{external_id}")
    rescue RestClient::ExceptionWithResponse => e
      nil
    end

  end
end
