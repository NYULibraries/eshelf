module OldEshelf
  class OldRecord < OldBase
    self.table_name = "records"
    belongs_to :old_user, foreign_key: 'user_id'
    has_many :old_taggings, foreign_key: 'taggable_id'
    serialize :record_attributes

    # Old mappings
    def old_title; title end
    def old_author; author end
    def old_title_sort; title_sort end
    def old_content_type; attributes["format"] end
    def old_url; url || "" end

    def old_format
      case self.external_system
      when "primo" then "pnx"
      when "xerxes" then "xerxes_xml"
      else "unknown"
      end
    end

    def old_data
      # Sometimes the key is a string and sometimes a symbol.
      # Check for both.
      (raw_xml.present?) ? raw_xml : ""
    rescue => e
      log.info("[ID=#{self.id}] Record raw_xml failed to load: #{e}")
      return ""
    end

    def old_tag_list
      OldTag.find(old_taggings.collect{|old_tagging| old_tagging.tag_id}).collect{|old_tag|
        old_tag.name }.join(", ")
    end

    def raw_xml
      (self.record_attributes["raw_xml"] || self.record_attributes[:raw_xml])
    end

    def log
      @log ||= Logger.new(Rails.root.join('log','old_eshelf_record_error.log'))
    end
  end
end
