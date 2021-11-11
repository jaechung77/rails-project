# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# subjects table 
#  subjects = %w(Math Chemistry Physics PE World-History Psychology Socialogy Computer Music Drama Art English)
# subjects.each do |s|
#     Subject.create({name: s})
# end

# teachers table
# 30.times do
# fullname = Faker::Name.unique.name.split(' ')
# Teacher.create({first_name: fullname[0], last_name: fullname[1], major: subjects[rand(0..11)]})
# end

# teaching table
# 50.times do
# Teaching.create(subject_id: rand(1..11), teacher_id: rand(1..50))
# end

# timetable table
# days = %w(Mon Tue Wed Thr Fri)
# i = 1
# (1..11).each do
#     3.times do
#         start_time = rand(9..15)
#         Timetable.create(subject_id: i, day: days[rand(0..4)], start_time: start_time, end_time: start_time+2 )
#     end
#     i = i + 1
# end

# i = 1
# (1..12).each do
#     subject = Subject.find(i)
#     subject.description = Faker::Lorem.paragraph(sentence_count: rand(7..10))
#     subject.save
#     i = i + 1
# end    

i=22
(22..50).each do
    teaching = Teaching.find(i)
    teaching.teacher_id = rand(41..80)
    teaching.save
    i = i + 1
end    
