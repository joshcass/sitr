class CreateNests < ActiveRecord::Migration
  def change
    create_table :nests do |t|
      t.string :token
      t.string :expiration
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
