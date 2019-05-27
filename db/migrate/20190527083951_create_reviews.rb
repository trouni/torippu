class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :booking, foreign_key: true
      t.references :reviewed, foreign_key: { to_table: :users }
      t.string :comment
      t.float :rating

      t.timestamps
    end
  end
end
