class RemoveNameScreenNameAndUidFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :name
    remove_column :users, :screen_name
    remove_column :users, :uid
  end
end
