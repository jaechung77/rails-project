class Student < ApplicationRecord
    has_many :enrolments
    has_many :teachings, through: :enrolments
    belongs_to :user
end
