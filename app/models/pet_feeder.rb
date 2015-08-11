class PetFeeder < ActiveRecord::Base
  include HTTParty
  belongs_to :user
  has_many :feed_times, dependent: :destroy

  validates :url, presence: true
  validates :url, url: true
  validates :name, uniqueness: true

  def feed_now
    auth = {username: 'sitrfeeder', password: 'b6nv@HJHqBLE0JOsC6' }
    HTTParty.post(url, query: {token: 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d'}, basic_auth: auth )
  end
end
