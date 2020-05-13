class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :allocation
  validates :status, presence: true
end
