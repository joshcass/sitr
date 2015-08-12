class FeedScheduler

  def execute
    feed_times = FeedTime.all

    feed_times.each do |feed_time|
      if can_feed?(feed_time)
        feed_time.pet_feeder.feed_now
      end
    end
  end

  def can_feed?(feed_time)
    last_five_minutes?(feed_time.time) && !last_five_minutes?(feed_time.pet_feeder.last_feeding)
  end

  def last_five_minutes?(time)
    time_today(time) >= 5.minutes.ago && time_today(time) < Time.now
  end

  def time_today(time)
    Time.parse(time.strftime('%R'))
  end
end
