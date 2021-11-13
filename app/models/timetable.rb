class Timetable < ApplicationRecord
    belongs_to :subject
    has_one :teaching, through: :subject

    def timetable_info
        "#{self.day} #{self.start_time}~#{self.end_time}"
    end
end
