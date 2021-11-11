class Teacher < ApplicationRecord
    has_many :teachings
    has_many :subjects, through: :teachings
    has_many :enrolments, through: :subjects
end
