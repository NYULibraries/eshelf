class User < ActiveRecord::Base

  has_many :records, :dependent => :destroy
  # Users act as taggers
  acts_as_tagger

  # Make pretty URLs for users based on their usernames
  def to_param; username end

  def self.first_or_initialize_from_old_user(old_user)
    raise_argument_error_unless_old_user(old_user)
    user = User.where(username: old_user.username).first_or_initialize
    # Only keep some old user data
    [:email, :firstname, :lastname].each do |attribute|
      old_value = old_user.send("old_#{attribute}".to_sym)
      user.send "#{attribute}=".to_sym, old_value
    end
    user
  end

  def initialize_records_from_old_user(old_user)
    self.class.raise_argument_error_unless_old_user(old_user)
    old_user.old_records.each do |old_record|
      # If we already have the record, skip it.
      next if records.find_by_external_system_and_external_id(old_record.external_system, old_record.external_id)
      # Create and update from source if appropriate
      record = records.new(external_system: old_record.external_system, external_id: old_record.external_id).becomes_external_system
      # Set the attributes from the external system
      # record.set_attributes_from_external_system
      # Only keep some old record data
      # but don't override
      [:format, :data, :title, :author, :title_sort, :content_type, :url].each do |attribute|
        old_value = old_record.send("old_#{attribute}".to_sym)
        next if old_value.nil?
        record.send "#{attribute}=".to_sym, old_value.force_encoding("UTF-8") if record.send(attribute).blank?
      end
      # Set the attributes from the external system again, in case there was a problem the first
      # time around, e.g. bad dedup id for Primo.
      # record.set_attributes_from_external_system
      record.created_at = old_record.created_at
      record.updated_at = Time.now
    end
    records
  end

  def tag_records_from_old_user(old_user)
    self.class.raise_argument_error_unless_old_user(old_user)
    old_user.old_records.each do |old_record|
      # Skip if no old_tag_list
      next if old_record.old_tag_list.empty?
      record = records.find_by_external_system_and_external_id(old_record.external_system, old_record.external_id)
      # Skip if no record
      next unless record
      # Need to double escape quotes for ActsAsTaggableOn
      tag record, with: old_record.old_tag_list.gsub(/\"/, "\"\""), on: :tags
    end
  end

  def self.raise_argument_error_unless_old_user(old_user)
    raise ArgumentError.new("Argument needs to be an OldEshelf::OldUser") unless old_user.is_a? OldEshelf::OldUser
  end
end
