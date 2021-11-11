class Teaching < ApplicationRecord
    belongs_to :subject
    belongs_to :teacher
end
