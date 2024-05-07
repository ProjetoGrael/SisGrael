class Occurrence < ApplicationRecord
  belongs_to :student
  belongs_to :user
  belongs_to :school_year, class_name: "Academic::SchoolYear"

  validates :description, presence: true
end
