class Financial::Account < ApplicationRecord
    has_many :transactions, dependent: :destroy

    # TODO: no momento de criação desta validation, não foi
    # checada a quantidade de dígitos de uma conta bancaria
    validates :number, presence: true, length: {in: 6..20}
    validates :agency, presence: true, length: {in: 3..10}
    validates :bank, presence: true, length: {in: 2..40}
    validates :current_value, presence: true, numericality: true

    def self.get_report_data(info)
      beggining = info[:beggining]
      finish = info[:final]
      id = info[:id]
      
      answer = Financial::Transaction.where(
        'account_id = (?) AND transaction_date >= (?) AND transaction_date <= (?)',
        id, beggining, finish
      )
      return answer
    end
end
