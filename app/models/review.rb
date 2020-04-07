class Review < ApplicationRecord
  belongs_to :camera
  validates :content, length: { minimum: 5 }
end
