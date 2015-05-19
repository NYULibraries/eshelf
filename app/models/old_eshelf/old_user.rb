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
      return true unless self.mobile_phone.present?
      patron = Exlibris::Aleph::API::Client::Patron.new(self.mobile_phone)
      return true if patron.error? && patron.reply_text == "The patron ID is invalid"
      return false
    end
  end
end
