class Academic::SubjectLevel < ApplicationRecord
  belongs_to :subject

  validates :name, presence: true, length: { maximum: 50 }
  validates :order, presence: true, numericality: { greater_than: 0 }
  validate :subject_must_be_leveled

  def full_name
    subject.name+" "+name
  end
  private

    def subject_must_be_leveled
      unless subject.leveled
        errors.add(:subject, "precisa ser Nivelada.")
      end
    end
end
