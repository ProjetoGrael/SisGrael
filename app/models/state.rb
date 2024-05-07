class State < ApplicationRecord
  has_many :cities, dependent: :restrict_with_error
  has_many :students, dependent: :restrict_with_error
end
