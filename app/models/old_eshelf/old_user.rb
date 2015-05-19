module OldEshelf
  class OldUser < OldBase
    self.table_name = "users"
    has_many :old_records, foreign_key: 'user_id'
    scope :accessed_this_year, lambda{ where("updated_at > ?", (Date.today.month >= 9) ? DateTime.new(Date.today.prev_year.year, 9) : DateTime.new((Date.today - 2.years).year, 9)) }
    scope :accessed_last_year, lambda{ where("updated_at > ?", 2.year.ago) }
    def old_email; email end
    def old_firstname; firstname end
    def old_lastname; lastname end

    def expired?
      if patron.present?
        log.info("[ID=#{self.id}] User not found in Aleph: NYUIDN: #{self.mobile_phone}")
        return true
      end
      if patron.error? && patron.reply_text == "The patron ID is invalid"
        log.info("[ID=#{self.id}] User not found in Aleph: NYUIDN: #{self.mobile_phone}")
        return true
      end
      return false
    end

    def patron
      @patron ||= Exlibris::Aleph::API::Client::Patron.new(self.mobile_phone) unless self.mobile_phone.blank?
    end

    def log
      @log ||= Logger.new(Rails.root.join('log','old_eshelf_user_error.log'))
    end
  end
end
