web: bundle exec puma -C config/puma.rb
worker: bundle exec rake environment resque:work QUEUES=* TERM_CHILD=1 RESQUE_TERM_TIMEOUT=7
clock: bundle exec clockwork lib/clock.rb