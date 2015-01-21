class Location < ActiveRecord::Base
  belongs_to :record

  # Validate presence of either a call number or a collection
  validates :call_number, presence: true, :if => Proc.new { collection.blank? }
  validates :collection, presence: true, :if => Proc.new { call_number.blank? }

  def to_s
    "#{collection} #{call_number}".strip
  end
end
