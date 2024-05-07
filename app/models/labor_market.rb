class LaborMarket < ApplicationRecord
  belongs_to :student

  validates :year, presence: true
  validates :year, length: { is: 4 }
  validates :year, numericality: { only_integer: true }
end
