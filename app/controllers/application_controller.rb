class ApplicationController < ActionController::Base
  include ApplicationHelper
  require 'will_paginate/array'
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :current_user_ban?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to acesso_negado_path, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
      format.xlsx { redirect_to acesso_negado_path, notice: exception.message }
      format.pdf  { redirect_to acesso_negado_path, notice: exception.message }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :kind])
  end

  def after_sign_in_path_for(resource)
    if resource.financial?
      financial_index_path
    elsif resource.admin?
      main_index_path
    elsif resource.social_service?
      social_service_index_path
    elsif resource.instructor? && resource.teacher.blank?
      flash.notice = 'Por favor, preencha o cadastro de Educador.'
      new_user_teacher_path(resource)
    elsif resource.instructor?
      teacher_panel_path(resource.teacher.id)
    elsif resource.secretary?
      secretary_index_path
    elsif resource.pedagogue?
      pedagogue_index_path
    elsif resource.coordination?
      coordination_index_path
    elsif resource.administration?
      administration_index_path
    end
  end

  
end
