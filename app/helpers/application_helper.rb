module ApplicationHelper
  def paginacao(elementos)
    will_paginate elementos, inner_window: 2, outer_window: 0, link_separator: "&nbsp;&nbsp;", previous_label: "<", next_label: ">"
  end

  def active_options
    [["Ativo", true], ["Inativo", false]]
  end

  def pretty_active(active)
    active ? 'Ativo' : 'Inativo'
  end

  def my_index
    if can? :manage, :all
      main_index_path
    elsif can? :manage, :financial
      financial_index_path
    elsif current_user.social_service?
      social_service_index_path
    elsif can? :manage, :secretary
      secretary_index_path
    elsif current_user.instructor? && current_user.teacher.present?
      teacher_panel_path(current_user.teacher.id)
    elsif current_user.pedagogue?
      pedagogue_index_path
    elsif current_user.coordination?
      coordination_index_path
    elsif current_user.administration?
      administration_index_path
    end
  end

  def pretty_date(date)
    if date.present?
      date.strftime('%d/%m/%Y')
    else
      'Não Informado'
    end
  end

  def pretty_bool(bool)
    if bool
      'Sim'
    else
      'Não'
    end
  end

  # para o enum de Student
  def pretty_school_shift(shift)
    hash = {
      morning: 'Manhã',
      afternoon: 'Tarde',
      night: 'Noite',
      integral: 'Integral'
    }
    hash[shift.to_sym]
  end

  def monetary_string_to_decimal(string)
    string = string.gsub('.', '')
    string = string.gsub(',', '.')
    string = string.remove('R$ ')
    string = string.remove('R$')
    string = "0.00" if !string.present?
    BigDecimal.new(string)
  end

  def current_school_year
    Academic::SchoolYear.current
  end

  def json_errors_response_translate(errors)
    messages = errors.messages

    # hash = {}

    # messages.each do |key, array|
    #     hash[key] = array
    # end

    messages
  end

  def self.asset_data_base64(path)
    return unless Rails.application.assets

    asset = Rails.application.assets.find_asset(path)
    throw "Could not find asset '#{path}'" if asset.nil?
    base64 = Base64.encode64(asset.to_s).gsub(/\s+/, "")
    "data:#{asset.content_type};base64,#{Rack::Utils.escape(base64)}"
  end
end
