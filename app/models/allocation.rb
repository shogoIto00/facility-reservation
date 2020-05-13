class Allocation < ApplicationRecord
  belongs_to :room
  belongs_to :timeslot
  has_one :reservations
  validates :date, presence: true
  validates :status, presence: true
end
