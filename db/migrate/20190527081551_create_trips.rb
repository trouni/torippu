class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :description
      t.integer :seats_available
      t.string :start_point
      t.string :end_point
      t.date :start_date
      t.date :end_date
      t.references :driver, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
