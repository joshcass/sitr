class AddColumnsToPetFeeder < ActiveRecord::Migration
  def change
    add_column :pet_feeders, :username, :string
    add_column :pet_feeders, :password, :string
    add_column :pet_feeders, :token, :string
    add_column :pet_feeders, :last_feeding, :datetime
  end
end
