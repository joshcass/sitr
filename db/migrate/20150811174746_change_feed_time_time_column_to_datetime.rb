class ChangeFeedTimeTimeColumnToDatetime < ActiveRecord::Migration
  def change
    remove_column :feed_times, :time
    add_column :feed_times, :time, :datetime
  end
end
