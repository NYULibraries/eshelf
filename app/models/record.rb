class Record < ActiveRecord::Base
  belongs_to :user
  belongs_to :tmp_user
  has_many :locations, :dependent => :destroy
  paginates_per 10
  # Subclasses are defined by their external system
  inheritance_column= :external_system
  # Set the attributes from external system before the record is validated
  # Default title sort if one isn't include initially
  before_validation :set_attributes_from_external_system, :default_title_sort, :normalize_content_type
  # After we've saved, create the locations from the external system, if necessary
  after_save :create_locations_from_external_system
  acts_as_citable
  # Records act as taggable
  acts_as_taggable
  # Alias #is_taggable? with #taggable? for convenience
  alias_method :taggable?, :is_taggable?
  # Validate presence of external_system, external_id, title, url, format,
  # data and title sort
  validates :external_system, :external_id, :title, :url, :format,
    :data, :title_sort, presence: true
  # Validate presence of either a user or a tmp user
  validates :user_id, :if => Proc.new { tmp_user_id.blank? }, presence: true
  validates :tmp_user_id, :if => Proc.new { user_id.blank? }, presence: true
  # Validate uniqueness of external id for each user/external system
  validates :external_id, :unless => Proc.new { user_id.blank? },
    uniqueness: { scope: [:user_id, :external_system] }
  # Validate uniqueness of external id for each tmp user/external system
  validates :external_id, :unless => Proc.new { tmp_user_id.blank? },
    uniqueness: { scope: [:tmp_user_id, :external_system] }
  # Should we validate URLs?
  # We're not actually storing URLs in DB, instead
  # we're storing OpenURLs (Context Objects).
  # Could validate those, but probably not necessary.
  # validates_format_of :url, :with => some OpenURL validation

  # Return the (unique) list of content types for records
  def self.content_types
    select(:content_type).uniq
  end

  # Sets the external system
  def set_attributes_from_external_system
    self.external_system = self.class.name.demodulize.downcase if external_system.blank?
    external_attributes_method = "#{external_system}_attributes".to_sym
    send(external_attributes_method) if respond_to?(external_attributes_method)
  end

  # Set the title sort to title unless specified otherwise
  def default_title_sort
    self.title_sort = title if title_sort.blank?
  end

  # Normalize the content type
  def normalize_content_type
    self.content_type = content_type.downcase unless content_type.nil?
  end

  # Sets the locations from the external system
  def create_locations_from_external_system
    return unless locations.blank?
    external_locations_method = "#{external_system}_locations".to_sym
    locations.create send(external_locations_method) if respond_to? external_locations_method
  end

  # Returns an instance of the record as an external system model,
  # e.g. Primo
  def becomes_external_system
    (external_system.capitalize.safe_constantize) ?
      becomes(external_system.capitalize.safe_constantize) : self
  end

  def rebuild_openurl!(institution = 'NYU')
    # We need to continue to support Xerxes openurls for existing Records
    # even though no new Xerxes records can be created
    if self.external_system == "primo"
      self.url = Eshelf::PnxJson.new(self.external_id, institution).openurl
      self.save!
    end
  end

  def expired?
    self.updated_at && (1.week.ago > self.updated_at)
  end
end
