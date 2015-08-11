class FeedScheduler

  def execute
    feed_times = FeedTime.all

    feed_times.each do |feed_time|
      if feed_time_today(feed_time) >= 5.minutes.ago && feed_time_today(feed_time) < Time.now
        feed_time.pet_feeder.feed_now
      end
    end
  end

  def feed_time_today(feed_time)
    Time.parse(feed_time.time.strftime('%R'))
  end
end
