class Reservation < ApplicationRecord
  belongs_to :camera
  belongs_to :user

  validates :day, presence: true
end
