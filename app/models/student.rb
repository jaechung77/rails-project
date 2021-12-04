class Student < ApplicationRecord
    has_many :enrolments
    has_many :teachings, through: :enrolments
    belongs_to :user
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :mobile, presence: true
    accepts_nested_attributes_for :enrolments
end
