class Student < ApplicationRecord
    belongs_to :user
    has_many :enrolments
    has_many :teachings, through: :enrolments
    
end
