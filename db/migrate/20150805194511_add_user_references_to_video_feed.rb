class AddUserReferencesToVideoFeed < ActiveRecord::Migration
  def change
    add_reference :video_feeds, :user, index: true, foreign_key: true
  end
end
