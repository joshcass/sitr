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
    check_response(response)
  end

  def auth_feed
    HTTParty.post(url, query: {token: token}, basic_auth: {username: username, password: password })
  end

  def feed
    HTTParty.post(url, query: {token: token})
  end

  def check_response(response)
    if response.success?
      update_feed_time
      response.code
    else
      response.code
    end
  end

  def update_feed_time
    update(last_feeding: Time.now)
  end

  def next_feeding
    feed_times.detect { |t| t.time.in_time_zone(user.time_zone).strftime( "%H%M%S%N" ) > Time.now.in_time_zone(user.time_zone).strftime( "%H%M%S%N" ) }
  end
end
