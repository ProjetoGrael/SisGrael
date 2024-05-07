module ReportsHelper
  def report_options
    [
      ['Natureza de Transação', :transaction_category],
      ['Conta Bancária', :account],
      ['Classe', :organization],
      ['Empresa', :enterprise]
    ]
  end
end
