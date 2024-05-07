class Financial::Transaction < ApplicationRecord
  belongs_to :transaction_category, optional: true
  belongs_to :account
  belongs_to :payer, class_name: "Institution"
  belongs_to :receiver, class_name: "Institution"
  validates :transaction_date, presence: true
  validates :value, presence: true, numericality: true
  validates :description, length: {in: 0..1000}, allow_nil: true

end
