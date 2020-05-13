class Room < ApplicationRecord
  belongs_to :facility
  validates :name, presence: true, length: { maximum: 255 }
  validates :purpose, presence: true
  validates :price, presence: true
  validates :maximum_capacity, presence: true
  has_many :allocations
end
