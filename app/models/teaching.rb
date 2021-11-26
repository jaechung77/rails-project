class Teaching < ApplicationRecord
    belongs_to :subject
    belongs_to :teacher
    has_many :enrolments
    has_many :users, through: :enrolments
    has_many :timetables, through: :subject
    accepts_nested_attributes_for :teacher
    accepts_nested_attributes_for :subject

    def subject_info
        "#{self.subject.name} - #{self.teacher.full_name}" 
    end    
end
