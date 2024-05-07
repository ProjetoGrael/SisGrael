class Expense < ApplicationRecord
    belongs_to :student

    validates :name, :presence => true
    validates :value, :numericality => true, :presence => true
end
