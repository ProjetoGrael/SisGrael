class Neighborhood < ApplicationRecord
  belongs_to :city
  has_many :students, dependent: :restrict_with_error
  
  validates :name, presence: true
  validates :city_id, presence: true
  
end
