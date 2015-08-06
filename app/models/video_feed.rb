class VideoFeed < ActiveRecord::Base
  belongs_to :user
  validates :url, presence: true
  validates :url, url: true
  validates :location, uniqueness: true
end
