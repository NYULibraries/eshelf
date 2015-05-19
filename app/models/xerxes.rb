class Xerxes < Record

  # Grabs missing attributes from the given Xerxes XML
  def xerxes_attributes
    self.format = "xerxes_xml"
    unless data.blank?
      self.title = normalized_str :normalizedTitle if title.blank?
      self.author = normalized_str :author if author.blank?
      self.content_type = normalized_str :content_type if content_type.blank?
      begin
        self.url = "#{to_openurl}" if url.blank?
      rescue => e
        self.url = "http://dev.getit.library.nyu.edu"
      end
    end
  end

  # Return locations array for Xerxes
  def xerxes_locations
    @xerxes_locations ||= normalized(:callNumber).collect do |node|
      { call_number: node }
    end
  end

  # Returns a String of normalized attributes for the given
  # attribute, separated by semicolons
  def normalized_str(attribute)
    normalized(attribute).join("; ")
  end

  # Returns an Array of normalized values for the given attribute
  # Return empty Array if the attribute is not mapped or not present in
  # the Record's data
  # Leverage the fact that Records "act as citable" and get the normalized
  # version of the given attribute
  def normalized(attribute)
    @normalized ||= csf
    (@normalized.respond_to?(attribute)) ? @normalized.send(attribute) : []
  end
end
