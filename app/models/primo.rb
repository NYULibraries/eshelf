class Primo < Record

  # Grabs missing attributes from the Primo web service
  def primo_attributes
    self.format = "pnx"
    unless primo_record.nil?
      self.data = primo_record.to_xml if data.blank?
      self.title = primo_record.display_title if title.blank?
      self.title_sort = primo_record.sort_title if title_sort.blank?
      self.content_type = primo_record.display_type if content_type.blank?
      self.author = primo_authors.join("; ") if author.blank?
      self.url = Eshelf::Citation.new(self.external_id, institution).openurl if url.blank?
    end
  end

  # Return hashes to create locations for Primo
  # TODO: go to Primo source
  def primo_locations
    unless primo_record.nil?
      @primo_locations ||= primo_record.holdings.collect do |holding|
        { collection: "#{holding.library} #{holding.collection}",
          call_number: holding.call_number }
      end
    end
  end

  # Returns an Exlibris::Primo::Record
  # TODO:
  #   Param :refresh forces a trip to the web service.
  def primo_record
    # If we don't have data for Primo, call the web service.
    # Otherwise, create the record from that data.
    @primo_record ||= (data.blank?) ?
      Exlibris::Primo::Search.new.record_id!(external_id).records.first :
        Exlibris::Primo::Record.new(raw_xml: data)
  end
  private :primo_record

  # Returns an array authors from the Exlibris::Primo::Record addata section
  def primo_authors
    @primo_authors ||=
      primo_record.all_addata_au.concat primo_record.all_addata_addau
  end
  private :primo_authors
end
