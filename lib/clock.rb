require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  every(10.seconds, 'feed_schedule') { Resque.enqueue(FeedScheduleJob) }
end
