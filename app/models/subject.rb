class Subject < ApplicationRecord
    has_many :enrolments
    has_many :timetables
    has_many :teachings
    has_many :teachers, through: :teachings
end
