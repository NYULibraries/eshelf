class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:nyulibraries]

  has_many :records, :dependent => :destroy
  # Users act as taggers
  acts_as_tagger

  # Make pretty URLs for users based on their usernames
  def to_param; username end
end
