module UsersHelper
  def user_kinds
    [
      ["Padrão", :standard],
      ["Administrador", :admin],
      ["Secretaria", :secretary],
      ["Instrutor", :instructor],
      ["Pedagogo", :pedagogue],
      ["Serviço Social", :social_service],
      ["Coordenação", :coordination],
      ["Gerência", :administration],
      ["Financeiro", :financial]
    ]
  end

  def pretty_user_kinds(kind)
    hash = {
      standard: "Padrão",
      admin: "Administrador",
      secretary: "Secretaria",
      instructor: "Instrutor",
      pedagogue: "Pedagogo",
      social_service: "Serviço Social",
      coordination: "Coordenação",
      administration: "Gerência",
      financial: "Financeiro"
    }
    hash[kind.to_sym]
  end
end
