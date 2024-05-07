class SocialServiceController < ApplicationController

    def students
        #Se o usuário não for do serviço social ou admin, retira ele da pagina...
        if !current_user.social_service? and !current_user.admin?
            redirect_to root_url
        end
        @inscriptions = Academic::Inscription.active.order('(student_id)').joins(:classroom).where(classrooms: {school_year_id: Academic::SchoolYear.current.id})

        if params[:term]
            students = Student.where("name ILIKE (?)", "%#{params[:term]}%").or(Student.where('registration_number ILIKE (?)',"%#{params[:term]}%")).or(Student.where('cpf ILIKE (?)',"%#{params[:term]}%"))
            @students = students.order('LOWER(name)').paginate(page: params[:page], per_page: 20)
        else
            if params[:idade_min] != nil && params[:idade_max] != nil
                if params[:idade_min] != "" && params[:idade_max] != ""
                    idade_min = params[:idade_min].to_i
                    idade_max = params[:idade_max].to_i
                    students = Student.where("birthdate < ?", Time.now.to_date - idade_min.year).where("birthdate > ?", Time.now.to_date - idade_max.year)
                    @students = students.order('LOWER(name)').paginate(page: params[:page], per_page: 20)
                elsif params[:idade_min] != "" && params[:idade_max] == ""
                    idade_min = params[:idade_min].to_i
                    students = Student.where("birthdate < ?", Time.now.to_date - idade_min.year)
                    @students = students.order('LOWER(name)').paginate(page: params[:page], per_page: 20)
                elsif params[:idade_min] == "" && params[:idade_max] != ""
                    idade_max = params[:idade_max].to_i
                    students = Student.where("birthdate > ?", Time.now.to_date - idade_max.year)
                    @students = students.order('LOWER(name)').paginate(page: params[:page], per_page: 20)
                elsif params[:idade_min] == "" && params[:idade_max] == ""
                    @students = Student.order('LOWER(name)').paginate(page: params[:page], per_page: 20)
                end
            else
                @students = Student.order('LOWER(name)').paginate(page: params[:page], per_page: 20)
            end
        end
    end

end
