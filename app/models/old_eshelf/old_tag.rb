module OldEshelf
  class OldTag < OldBase
    has_many :old_taggings, foreign_key: 'tag_id'
    self.table_name = "tags"
  end
end
