class PetFeeder < ActiveRecord::Base
  include HTTParty
  belongs_to :user
  has_many :feed_times, dependent: :destroy

  validates :url, presence: true
  validates :url, url: true
  validates :name, uniqueness: true

  def feed_now
    HTTParty.get(url, query: {feed: 'Fed!'} )
  end
end
