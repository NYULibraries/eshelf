module RecordDecorator
  # Record decorated with normalized values from the
  # record's Citation Standard Format (CSF)
  #
  # Author::    scotdalton
  # Copyright:: Copyright (c) 2013 New York University
  # License::   Distributes under the same terms as Ruby
  class NormalizeDecorator < Base
    def title
      "#{super} (#{content_type.downcase})"
    end

    def url
      (view_context.nil?) ? super : view_context.getit_record_url(base)
    end

    def locations
      @locations ||= super.collect { |location| location.to_s }
    end

    def author
      # CSF prefers author to contributor,
      # so there will only ever be a contributor
      # if there is an author.
      unless normalize(:author).blank?
        author = normalize :author
        # If we have contributors, append them.
        author += "; #{normalize :contributor}" unless normalize(:contributor).blank?
        return author
      end
    end

    def publisher
      normalize :publisher
    end

    def city_of_publication
      normalize :place
    end

    def date_of_publication
      normalize :date
    end

    def journal_title
      normalize :journal_title
    end

    def subjects
      normalize :tags
    end

    def issn
      normalize :issn
    end

    def eissn
      normalize :eissn
    end

    def isbn
      normalize :isbn
    end

    def related_titles
      normalize :related_titles
    end

    def language
      normalize :language
    end

    def description
      normalize :description
    end

    def notes
      normalize :notes
    end

    # Data will come back as either a hash or JSON that we want to parse into a has
    # let's be ready for either scenario
    def data
      @data ||= begin
        (normalized.data.is_a?(Hash)) ? normalized.data :
          JSON.parse(normalized.data.gsub('=>', ':'))
      rescue JSON::ParserError => e
        {}
      end
    end

    def normalized
      # If Citero doesn't know this from format or the data is blank, just return base.
      # Or if format is PNX_JSON, use the JSON data instead of CSF
      @normalized ||= (Citero.from_formats.include?(base.format.to_sym) and (!base.data.blank?) and (base.format.to_sym != :pnx_json)) ? csf : base
    end
    private :normalized

    def normalize(attribute)
      if normalized.respond_to?(attribute)
        normalized_value = normalized.send(attribute) 
      elsif data[attribute.to_s]
        normalized_value = data[attribute.to_s]
      end
      (normalized_value.respond_to? :uniq) ? normalized_value.uniq.join("; ") : normalized_value
    end
    private :normalize
  end
end
