module RecordDecorator
  # Record decorated with labels.
  # Expects a normalized record.
  #
  # Author::    scotdalton
  # Copyright:: Copyright (c) 2013 New York University
  # License::   Distributes under the same terms as Ruby
  class LabelDecorator < Base
    def locations_label
      (external_system.eql? "xerxes") ?
        I18n.t('record.call_number_label') : I18n.t('record.locations_label')
    end

    def url
      @url ||= label(:url, super)
    end

    def author
      label(:author, super)
    end

    def publisher
      label(:publisher, super)
    end

    def city_of_publication
      label(:city_of_publication, super)
    end

    def date_of_publication
      label(:date_of_publication, super)
    end

    def journal_title
      label(:journal_title, super)
    end

    def subjects
      label(:subjects, super)
    end

    def issn
      label(:issn, super)
    end

    def eissn
      label(:eissn, super)
    end

    def isbn
      label(:isbn, super)
    end

    def related_titles
      label(:related_titles, super)
    end

    def language
      label(:language, super)
    end

    def description
      label(:description, super)
    end

    def notes
      label(:notes, super)
    end

    def label(attribute, datum)
      "#{I18n.t("record.#{attribute}_label")} #{datum}" unless datum.blank?
    end
    private :label
  end
end
