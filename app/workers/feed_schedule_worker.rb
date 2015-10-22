class FeedScheduleWorker
  include Sidekiq::Worker

  def perform
    FeedScheduler.new.execute
  end
end
