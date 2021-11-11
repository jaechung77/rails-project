class Teacher < ApplicationRecord
    has_many :teachings
    has_many :subjects, through: :teachings
    has_many :enrolments, through: :teachings

    def full_name
        self.first_name + " " + self.last_name
    end
end
