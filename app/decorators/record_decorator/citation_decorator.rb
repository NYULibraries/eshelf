module RecordDecorator
  # Record with decorations for brief, medium and full citations.
  # 
  # Author::    scotdalton
  # Copyright:: Copyright (c) 2013 New York University
  # License::   Distributes under the same terms as Ruby
  class CitationDecorator < Base
    BRIEF = %w(title url locations)
    MEDIUM = %w(author publisher city_of_publication date_of_publication journal_title)
    FULL = %w(subjects issn eissn isbn related_titles language description notes)

    attr_reader :citation_style

    # Initialize with a record, an optional view_context and citation style
    def initialize(*args)
      @citation_style = args.pop
      super(*args)
    end

    def brief_attributes
      @brief_attributes ||= BRIEF
    end

    def medium_attributes
      @medium_attributes ||= brief_attributes + MEDIUM
    end

    def full_attributes
      @full_attributes ||= medium_attributes + FULL
    end
  end
end
