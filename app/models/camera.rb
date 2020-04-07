class Camera < ApplicationRecord

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  mount_uploader :photo, PhotoUploader
  belongs_to :owner, class_name: 'User'
  has_many :reservations, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true
  validates :photo, presence: true

  include PgSearch::Model

  pg_search_scope :search,
                  against: [:name, :address, :price],
                  using: {
                    tsearch: { prefix: true }
                  }
end
