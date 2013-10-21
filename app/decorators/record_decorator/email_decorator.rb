module RecordDecorator
  # Record decorations for email
  #
  # Author::    scotdalton
  # Copyright:: Copyright (c) 2013 New York University
  # License::   Distributes under the same terms as Ruby
  class EmailDecorator < Base
    # Return a string of labeled locations
    # formatted for an email
    def locations
      # Let ActiveSupport core extensions handle checking nil/empty for locations array
      # http://guides.rubyonrails.org/active_support_core_extensions.html#blank-and-present
      unless super.blank?
        if external_system.eql? "primo"
          separator = (super.size > 1) ? "\n\t" : ""
          "#{locations_label} #{separator}#{super.join(separator)}"
        else
          "#{locations_label} #{super.join("; ")}"
        end
      end
    end
  end
end
