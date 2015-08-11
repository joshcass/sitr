class PetFeeder < ActiveRecord::Base
  include HTTParty
  belongs_to :user
  has_many :feed_times, dependent: :destroy

  validates :url, presence: true, url: true
  validates :name, presence: true, uniqueness: true

  def feed_now
    if password.empty?
      feed
    else
      auth_feed
    end
    update(last_feeding: Time.now)
  end

  def auth_feed
    HTTParty.post(url, query: {token: token}, basic_auth: {username: username, password: password })
  end

  def feed
    HTTParty.post(url, query: {token: token})
  end
end
