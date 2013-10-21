module OldEshelf
  class OldBase < ActiveRecord::Base
    attr_accessible

    # Was an old eshelf connection set in database.yml?
    def self.connection_configured?
      config = ActiveRecord::Base.configurations["old_eshelf"]
      (not (config.nil? or config.blank? or config["adapter"].blank?))
    end

    self.establish_connection :old_eshelf if self.connection_configured?
    # ActiveRecord likes it when we tell it this is an abstract class only. 
    self.abstract_class = true

    # Just to be safe
    def read_only?
      true 
    end
  end
end
