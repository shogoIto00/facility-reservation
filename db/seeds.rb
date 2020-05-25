# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..9).each do |num_room|
    (1..9).each do |num_timeslot|
        (6..12).each do |month|
            (1..30).each do |day|
                Allocation.create(room_id: num_room , timeslot_id: num_timeslot, status: '利用可',date: '2020-' + month.to_s + '-' + day.to_s )
            end
        end
    end
end
