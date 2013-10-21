module RecordDecorator
  # Record with decorations specific to Articles
  # Expects a CitationDecorator as its base
  # TODO: Refactor to change this expectation
  # 
  # Author::    scotdalton
  # Copyright:: Copyright (c) 2013 New York University
  # License::   Distributes under the same terms as Ruby
  class ArticleDecorator < Base
    ARTICLE_BRIEF = %w(title journal_title url locations)
    ARTICLE_MEDIUM = %w(author publisher city_of_publication date_of_publication)

    def brief_attributes
      @brief_attributes ||= ARTICLE_BRIEF
    end

    def medium_attributes
      @medium_attributes ||= brief_attributes + ARTICLE_MEDIUM
    end

    def full_attributes
      @full_attributes ||= medium_attributes + CitationDecorator::FULL
    end
  end
end
