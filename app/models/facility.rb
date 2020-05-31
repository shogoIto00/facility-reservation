class Facility < ApplicationRecord
    has_many :rooms
    validates :name, presence: true
    validates :address, presence: true
    validates :access, presence: true
    has_one_attached :facility_photo
end
