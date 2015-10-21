web: bundle exec puma -C config/puma.rb
resque: bundle exec rake environment resque:work QUEUES=*
clock: bundle exec clockwork lib/clock.rb