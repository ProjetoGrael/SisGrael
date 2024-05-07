class School < ApplicationRecord
  has_many :students, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  
end
