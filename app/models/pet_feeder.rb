class PetFeeder < ActiveRecord::Base
  include HTTParty
  belongs_to :user
  has_many :feed_times, dependent: :destroy

  validates :url, presence: true, url: true
  validates :name, presence: true, uniqueness: true

  def feed_now
    if password.empty?
      response = feed
    else
      response = auth_feed
    end
    update_last_feeding if response.success?
    response
  end

  def auth_feed
    HTTParty.post(url, query: {token: token}, basic_auth: {username: username, password: password })
  end

  def feed
    HTTParty.post(url, query: {token: token})
  end

  def update_last_feeding
    update(last_feeding: Time.zone.now)
  end

  def next_feeding
    feed_times.detect { |feed_time| feed_time.time.in_time_zone(user.time_zone).strftime('%R') > Time.zone.now.in_time_zone(user.time_zone).strftime('%R') }
  end
end

