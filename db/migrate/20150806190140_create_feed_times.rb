class CreateFeedTimes < ActiveRecord::Migration
  def change
    create_table :feed_times do |t|
      t.time :time
      t.references :pet_feeder, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
