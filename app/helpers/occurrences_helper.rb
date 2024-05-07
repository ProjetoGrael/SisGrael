module OccurrencesHelper
    def occurrence_school_year_options
        Academic::SchoolYear.all.order(name: :asc).map {|el| [el.name, el.id]} 
    end

    def occurrence_student_options
        Student.all.order(name: :asc).map {|el| [el.name, el.id]} 
    end

    def occurrence_school_year_actual
        if Academic::SchoolYear.current.id
            return Academic::SchoolYear.current.id
        else
            Academic::SchoolYear.first.id
        end
    end
end
