class Subject < ApplicationRecord
    mount_uploader :image, ImageUploader
    has_many :teachings, dependent: :destroy
    has_many :teachers, through: :teachings
    has_many :enrolments, through: :teachings
end