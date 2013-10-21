module OldEshelf
  class OldTagging < OldBase
    belongs_to :old_record, foreign_key: 'taggable_id'
    belongs_to :old_tag, foreign_key: 'tag_id'
    self.table_name = "taggings"
  end
end
