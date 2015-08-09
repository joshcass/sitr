class FeedTime < ActiveRecord::Base
  belongs_to :pet_feeder

  validates :time, presence: true

  default_scope { order(:time) }
end
