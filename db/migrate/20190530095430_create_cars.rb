class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.references :owner_id, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
