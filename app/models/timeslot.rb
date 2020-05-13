class Timeslot < ApplicationRecord
    has_many :allocations
    validates :day_of_the_week, presence: true
    validates :time_start, presence: true
    validates :time_finish, presence: true
end
