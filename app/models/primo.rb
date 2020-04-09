class Primo < Record

  # Grabs missing attributes from the Primo web service
  def primo_attributes
    self.format = "pnx_json"
    unless primo_record.nil?
      self.data = primo_record if data.blank?
      self.title = primo_record["title"] if title.blank?
      self.title_sort = primo_record["title_sort"] if title_sort.blank?
      self.content_type = primo_record["itemType"] if content_type.blank?
      self.author = primo_authors.join("; ") if author.blank?
      self.url = citation.openurl if url.blank?
    end
  end

  def primo_locations
    unless primo_record.nil?
      @locations ||= primo_record["locations"].collect do |location|
        holding = location.match(/^(?<collection>.+)\s+\((?<call_number>.+)\)\s*$/)
        { collection: "#{holding[:collection].strip.gsub(/\s\s+/,' ')}",
          call_number: holding[:call_number].strip.gsub(/\s\s+/,' ') }
      end
    end
  end

 private

  # Returns a Hash with attributes
  def primo_record
    @primo_record ||= citation.record
  end

  # Returns the Eshelf::Citation object
  def citation
    @citation ||= Eshelf::Citation.new(self.external_id)
  end

  # Returns an array authors from the PNX_JSON addau section
  def primo_authors
    @primo_authors ||= (primo_record["addau"].nil?) ? [primo_record["author"]] : 
      [primo_record["author"]].concat(primo_record["addau"])
  end
end
