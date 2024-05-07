class Financial::TransactionCategory < ApplicationRecord
    has_many :transactions

    def self.get_report_data(info)
      beggining = info[:beggining]
      finish = info[:final]
      id = info[:id]
      
      answer = Financial::Transaction.where(
        'transaction_category_id = ? AND transaction_date >= ? AND transaction_date <= ?',
        id, beggining, finish
      )
      return answer
    end
end
