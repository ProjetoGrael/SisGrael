class Financial::Project < ApplicationRecord
    has_many :rubrics, dependent: :destroy
    has_many :captations, dependent: :destroy
    # has_many :transactions, through: :rubrics, dependent: :destroy

    validates :title, presence: true, length: {in: 3..200}
    validates :description, allow_nil: true, length: {in: 3..500}
    validates :total_value, numericality: true
    validates :current_value, numericality: true

    def adjust_current_value(values_diference)
        self.current_value -= values_diference
        self.save
      end
end
