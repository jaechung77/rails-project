class Teaching < ApplicationRecord
    belongs_to :subject
    belongs_to :teacher, dependent: :destroy
    has_many :enrolments, dependent: :destroy
    has_many :users, through: :enrolments
    accepts_nested_attributes_for :teacher
    accepts_nested_attributes_for :subject

    def subject_info
        "#{self.subject.name} - #{self.teacher.full_name}" 
    end    
end
