class CreatePetFeeders < ActiveRecord::Migration
  def change
    create_table :pet_feeders do |t|
      t.string :url
      t.string :name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
