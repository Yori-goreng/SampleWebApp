class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review
  counter_culture :review
end
