class StaticPageController < ApplicationController
  before_action only: [:principal] do 
    if cannot? :read, :all
      redirect_to my_index
    end
  end

  def principal
  end

  def monitoring
    
    user = current_user
    unless  user.admin? or user.coordination? or user.pedagogue? or user.social_service? or user.administration?
        redirect_to '/app/views/403.html', notice: "Permissão negada"  
      end
    # authorize! :read, :monitoring    
  end
  
  def monitoring_index
    
    user = current_user
    
    unless  user.admin? or user.coordination? or user.pedagogue? or user.social_service?
        redirect_to '/app/views/403.html', notice: "Permissão negada"  
      end
    @school_year_id = params[:school_year_id ] || Academic::SchoolYear.current.id || Academic::SchoolYear.first
    @school_year = Academic::SchoolYear.find(@school_year_id)
  end

  def livro_caixa
    authorize! :read, :financial
  end

  def report_secretary
    @school_years = Academic::SchoolYear.all
  end

  def pedagogue
  end

  def coordination
    @teachers = []
    Academic::Teacher.all.each do |teacher|
      frequency_list_pendant = teacher.frequency_list_pendant
      if frequency_list_pendant[:boolean]
        @teachers.push({"name": teacher.name, "number_of_frequency_list_pendant": frequency_list_pendant[:sum]})
      end
    end
  end
  
  def financeiro
    authorize! :read, :financial
  end

  def academico
  end

  def secretaria
    authorize! :read, :secretary
  end

  def servico_social
    authorize! :read, :servico_social
  end

  def administration
  end
end
