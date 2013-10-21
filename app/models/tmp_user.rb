class TmpUser < ActiveRecord::Base
  attr_accessible
  # Order records by descending creation date.
  # Use tmp_user.records.reorder to reorder
  has_many :records, dependent: :destroy, :order => 'created_at DESC'
end
