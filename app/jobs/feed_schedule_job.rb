class FeedScheduleJob
  @queue = :feed_schedule

  def self.perform
    FeedScheduler.new.execute
  end
end
