class Enrolment < ApplicationRecord
    belongs_to :teaching
    belongs_to :student
    has_many :teachers, through: :teachings
    has_many :subjects, through: :teachings
end
