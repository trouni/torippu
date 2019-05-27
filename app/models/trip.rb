class Trip < ApplicationRecord
  belongs_to :driver, class_name: "User"
end
