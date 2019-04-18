class TmpUser < ApplicationRecord
  # Order records by descending creation date.
  # Use tmp_user.records.reorder to reorder
  has_many :records, -> { order 'created_at DESC' }, :dependent => :destroy
end
