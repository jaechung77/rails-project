class Subject < ApplicationRecord
    has_many :teachings
    has_many :teachers, through: :teachings
    has_many :timetables
    has_many :enrolments, through: :teachings
end
