require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  every(5.minutes, 'feed_schedule') { Resque.enqueue(FeedScheduleJob) }
end
