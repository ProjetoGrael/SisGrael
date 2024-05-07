class Financial::Institution < ApplicationRecord
    enum kind: { 
        enterprise: 0,
        organization: 1
    }

    enum status: {
        inactive: 0,
        active: 1
    }

    has_many :transactions, dependent: :destroy, foreign_key: :payer_id
    has_many :transactions, dependent: :destroy, foreign_key: :receiver_id

    validates :name, presence: true, length: {in: 3..200}

    def self.get_report_data(info)
      beggining = info[:beggining]
      finish = info[:final]
      id = info[:id]
      
      answer = Financial::Transaction.where(
        '(payer_id = ? OR receiver_id = ?) AND transaction_date >= ? AND transaction_date <= ?',
        id, id, beggining, finish
      )
      return answer
    end
end
