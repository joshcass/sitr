class CreateVideoFeeds < ActiveRecord::Migration
  def change
    create_table :video_feeds do |t|
      t.string :location
      t.string :url

      t.timestamps null: false
    end
  end
end
