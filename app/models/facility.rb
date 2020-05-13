class Facility < ApplicationRecord
    has_many :rooms
    validates :name, presence: true
    validates :address, presence: true
    validates :access, presence: true
end
