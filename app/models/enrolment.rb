class Enrolment < ApplicationRecord
    belongs_to :subject
    belongs_to :student
    has_many :teachings, through: :students 
end
