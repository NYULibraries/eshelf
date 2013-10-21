module RecordDecorator
  # Record with decorations for printing
  #
  # Author::    scotdalton
  # Copyright:: Copyright (c) 2013 New York University
  # License::   Distributes under the same terms as Ruby
  class PrintDecorator < Base
    def title
      (view_context.nil?) ? super : view_context.content_tag(:strong, super)
    end

    # Return a string of labeled locations
    # formatted for print
    # TODO: This thing is DISGUSTING!
    def locations
      # Let ActiveSupport core extensions handle checking nil/empty for locations array
      # http://guides.rubyonrails.org/active_support_core_extensions.html#blank-and-present
      unless super.blank?
        if external_system.eql? "primo"
          if (super.size > 1)
            locations = view_context.content_tag(:div, "#{locations_label}")
            super.each do |location|
              locations += view_context.content_tag(:div, location, class: "location")
            end
            return locations
          else
            return "#{locations_label} #{super.join}"
          end
        else
         return "#{locations_label} #{super.join("; ")}"
        end
      end
    end

    def brief_attributes
      @brief_attributes ||= move_url_to_end(super)
    end

    def medium_attributes
      @medium_attributes ||= move_url_to_end(super)
    end

    def full_attributes
      @full_attributes ||= move_url_to_end(super)
    end

    # Returns an array with the URL removed from the given attributes and pushed onto the end
    def move_url_to_end(attributes)
      attributes.reject{|attribute| attribute.eql? "url"} << "url"
    end
    private :move_url_to_end
  end
end
