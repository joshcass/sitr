require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  every(5.minutes, 'feed_schedule') { Sidekiq::Client.push('class' => FeedScheduleWorker, 'args' => []) }
end
