module Academic::SchoolYearsHelper
  def school_year_value(resource)
    if resource.school_year_id.present?
      return resource.school_year_id
    else
      params[:school_year_id]
    end
  end

  def school_year_status_options
    [['Ativo', :active], ['Inativo', :inactive], ['Planejamento', :preparation]]
  end

  def pretty_school_year_status(school_year)
    hash = {
      active: 'Ativo',
      inactive: 'Inativo',
      preparation: 'Planejamento'
    }
    hash[school_year.status.to_sym]
  end
end
