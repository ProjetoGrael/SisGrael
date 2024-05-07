module Financial::TransactionsHelper
    
    def responsible_options
        Financial::Enterprise.all.collect { |r| [r.name, r.id] } + Financial::Institution.all.collect { |i| [i.name, i.id] }
    end

    def responsible_type_options
        [['Empresa', 'Enterprise'], ['Classe', 'Institution']]
    end

    def cost_type_options
        [['Projeto', 'Financial::Rubric'], ['Custo Fixo', 'Financial::FixedCost'], ['Outros Custos', nil]]
    end

    def receiver_options
        Financial::Institution.active.collect {|x| [x.name, x.id]}
    end

    def payer_options
        Financial::Institution.active.collect {|x| [x.name, x.id]}
    end

    def project_select_options
        Financial::Project.all.collect {|x| [x.title, x.id]}
    end

    def transaction_category_options
        Financial::TransactionCategory.all.collect {|x| [x.description, x.id]}
    end

    def first_project_rubrics
        Financial::Project.first.rubrics.collect {|x| [x.description, x.id]}
    end

    def account_options
        Financial::Account.all.collect { |a| [a.number, a.id] }
    end

    def display_account(account)
        account.bank + ' | ' + account.agency + '-' + account.number
    end
    
end
