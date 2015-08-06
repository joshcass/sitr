class PetFeeder < ActiveRecord::Base
  belongs_to :user
  has_many :feed_times, dependent: :destroy

  validates :url, presence: true
  validates :url, url: true
  validates :name, uniqueness: true
end
