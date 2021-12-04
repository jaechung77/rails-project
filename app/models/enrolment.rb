class Enrolment < ApplicationRecord
    belongs_to :teaching
    belongs_to :student
    has_many :teachers, through: :teachings
    has_many :subjects, through: :teachings
    validates :student_id, presence: true
    validates :teaching_id, presence: true
end
