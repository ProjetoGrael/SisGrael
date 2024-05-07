class CertificationController < ApplicationController
  before_action :set_student, only: [:available_certificates]
  before_action :validate_available_certificates, only: [:available_certificates]

  def show
    @inscriptions = Academic::Inscription.active.where(id: params[:inscription])

    render_pdf title_name: @inscriptions.first.student.name
  end

  def show_by_classroom
    @classroom = Academic::Classroom.find(params[:classroom])
    @classroom_subjects = @classroom.classroom_subjects
    @main_classroom_subject = Academic::ClassroomSubject.find(@classroom.main_id) if @classroom.main_id.present?
    @inscriptions = @classroom.inscriptions.active.where(situation: "approved").or(@classroom.inscriptions.where(situation: "participant"))
    
    render_pdf title_name: @classroom.fantasy_name
  end

  def available_certificates
    @inscriptions_approved = @student.inscriptions.active.where(situation: 'approved')
  end

  private

  #Validando 
  def validate_available_certificates
    if !can? :available_certificates, :certification
      authorize! :available_certificates, :certification
    end
  end

  def render_pdf(title_name: 'default')
    title = "Certificado de #{title_name} emitido em " + Date.today.strftime("%d/%m/%y")
    respond_to do |format|
      format.pdf do
        render pdf: title,
               template: 'certification/show.pdf.erb',
               orientation: 'Landscape',               
               title: title,
               margin: {bottom: 0,
                        top: 0,
                        left: 0,
                        right: 0 }
      end
    end
  end

  def set_student
    @student = Student.find(params[:student_id])
  end
end
