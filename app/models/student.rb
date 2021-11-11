class Student < ApplicationRecord
    belongs_to :user
    has_many :enrolments
    has_many :subjects, through: :enrolments
end
