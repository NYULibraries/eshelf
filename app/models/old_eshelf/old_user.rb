module OldEshelf
  class OldUser < OldBase
    self.table_name = "users"
    has_many :old_records, foreign_key: 'user_id'
    scope :accessed_this_year, lambda{ where("updated_at > ?", 1.year.ago) }
    scope :accessed_last_year, lambda{ where("updated_at > ?", 2.year.ago) }
    def old_email; email end
    def old_firstname; firstname end
    def old_lastname; lastname end
  end
end
