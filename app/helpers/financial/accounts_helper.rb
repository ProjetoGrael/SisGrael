module Financial::AccountsHelper
    def display_account(account)
        account.bank + ' | ' + account.agency + '-' + account.number
    end
end
