class City < ApplicationRecord
  belongs_to :state
  has_many :neighborhoods, dependent: :restrict_with_error
  has_many :students, dependent: :restrict_with_error
  
  validates :name, presence: true
  validates :state_id, presence: true

end
