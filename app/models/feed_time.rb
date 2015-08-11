class FeedTime < ActiveRecord::Base
  belongs_to :pet_feeder

  validates :time, presence: true, uniqueness: true

  default_scope { order(:time) }
end
