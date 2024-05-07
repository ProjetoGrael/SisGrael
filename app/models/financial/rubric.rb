class Financial::Rubric < ApplicationRecord
  before_create :set_numeration, :set_current_value
  # before_destroy :adjust_numerations, prepend: true

  belongs_to :project
  has_many :rubric_items, dependent: :destroy
  # has_many :transactions, dependent: :destroy, as: :cost

  validates :description, presence: true, length: {in: 3..200}
  validates :value, numericality: true
  
  def adjust_values(values_diference)
    self.current_value ||= BigDecimal.new("0.00")
    self.current_value += values_diference
  end

  def adjust_current_value(values_diference)
    self.current_value -= values_diference
    save
  end

  private

    def set_numeration
      self.numeration = self.project.rubrics.count + 1  # Financial::Rubric.where(project_id: self.project_id).count + 1
    end

    def set_current_value
      self.current_value = self.value
    end

    def adjust_numerations
      
      project = self.project
      position = numeration - 1
      project.rubrics[position..-1].each do |rubric|
         
        Financial::Rubric.find(rubric.id)&.update_attributes(numeration: (rubric.numeration - 1))
      end
    end
end
