class Enrolment < ApplicationRecord
    belongs_to :teaching
    belongs_to :user
    has_many :teachers, through: :teachings
    has_one :student, through: :user
    accepts_nested_attributes_for :student
end
