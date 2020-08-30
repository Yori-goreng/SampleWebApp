class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates :body, presence: true, length: { maximum: 200 }
  has_many :notifications, dependent: :destroy

end
