class User < ActiveRecord::Base
  has_secure_password
  has_many :video_feeds, dependent: :destroy
  has_many :pet_feeders, dependent: :destroy
  has_one :nest, dependent: :destroy
  validates :email, :time_zone, :password, presence: true
  validates :email, uniqueness: true
  validates_confirmation_of :password
  validates_format_of :email, with: /.+@.+\..+/i
end
