class Subject < ApplicationRecord
    mount_uploader :image, ImageUploader

    has_many :teachings
    has_many :teachers, through: :teachings
    has_many :timetables
    has_many :enrolments, through: :teachings

end
