class Review < ApplicationRecord
  belongs_to :trip
  belongs_to :reviewee, class_name: "User"
  belongs_to :reviewer, class_name: "User"
  validates :comment, presence: true
  validates :rating, inclusion: { in: 0..5 }
end
