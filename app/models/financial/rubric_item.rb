class Financial::RubricItem < ApplicationRecord
  belongs_to :rubric

  validates :description, allow_nil: true, length: {in: 3..500}
  validates :value, numericality: true

  before_create :set_numeration
  before_destroy :adjust_numerations

  private

    def set_numeration
      self.numeration = self.rubric.rubric_items.count + 1  # Financial::RubricItem.where(rubric_id: self.rubric_id).count + 1
    end

    def adjust_numerations
      rubric = self.rubric
      position = numeration - 1
      rubric.rubric_items[position..-1].each do |item|
        Financial::RubricItem.find(item.id)&.update_attributes(numeration: (item.numeration - 1))
      end
    end
end
