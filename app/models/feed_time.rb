class FeedTime < ActiveRecord::Base
  belongs_to :pet_feeder

  validates :time, presence: true, uniqueness: true

  default_scope { order(:time) }

  def time_today
    Time.zone.parse(time.strftime('%R'))
  end
end
