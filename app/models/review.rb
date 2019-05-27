class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :reviewed
end
