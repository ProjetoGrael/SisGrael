class Financial::Captation < ApplicationRecord
  belongs_to :project

  validates :source, presence: true, length: {in: 3..200}
  validates :value, numericality: true
end
