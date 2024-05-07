module Financial::OrganizationsHelper
    def kind_options
        [["Pagador", :giver], ["Recebedor", :taker]]
    end

    def status_options
        [["Ativo", :active], ["Inativo", :inactive]]
    end

    def translate_status(status)
        hash = {active: "Ativo", inactive: "Inativo"}
        hash[status.to_sym]
    end
end
