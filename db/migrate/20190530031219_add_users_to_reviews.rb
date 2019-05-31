class AddUsersToReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :trip, foreign_key: true
    add_reference :reviews, :reviewee, foreign_key: { to_table: :users }
    add_reference :reviews, :reviewer, foreign_key: { to_table: :users }
    remove_reference :reviews, :booking
    remove_reference :reviews, :user
  end
end
