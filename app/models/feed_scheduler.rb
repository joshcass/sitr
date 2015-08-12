class FeedScheduler

  def execute
    feed_times = FeedTime.all

    feed_times.each do |feed_time|
        feed_time.pet_feeder.feed_now if can_feed?(feed_time)
    end
  end

  def can_feed?(feed_time)
    last_five_minutes?(feed_time.time_today) && !last_five_minutes?(feed_time.pet_feeder.last_feeding)
  end

  def last_five_minutes?(time)
    time >= 5.minutes.ago && time <= Time.zone.now
  end
end
