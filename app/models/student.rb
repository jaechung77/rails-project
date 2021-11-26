class Student < ApplicationRecord
    has_many :enrolments
    has_many :teachings, through: :enrolments
    belongs_to :user
    accepts_nested_attributes_for :enrolments

    # def to_param
    #     student_id
    # end
end
