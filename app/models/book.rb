class Book < ApplicationRecord
   validates :body, length: { maximum: 200 }
   has_one_attached :image
   belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
end
