module VocationalInterviewsHelper

    def institution_kind_options
        VocationalInterview.last_attended_educational_institutions.keys
    end

    def live_with_options
        VocationalInterview.live_withs.keys
    end

    def housing_condition_options
        VocationalInterview.housing_conditions.keys
    end

    def motivation_options
        VocationalInterview.motivations.keys
    end

    def already_attended_which_options
        VocationalInterview.already_attended_whiches.keys
    end

    def already_attended_difference_options
        VocationalInterview.already_attended_differences.keys
    end

    def already_attended_difference_options
        VocationalInterview.already_attended_differences.keys
    end

    def project_access_options
        VocationalInterview.project_accesses.keys
    end

    def number_transport_options
        VocationalInterview.number_transports.keys
    end

    def family_life_options
        VocationalInterview.family_lives.keys
    end

    def urban_infrastructure_options
        VocationalInterview.urban_infrastructures.keys
    end

    def age(dob)
        now = Time.now.utc.to_date
        now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end

    def ethnicities_options
        VocationalInterview.ethnicities.keys
    end

    def dont_print_nil(string)
        if(string == nil or string == "")
            return "-"
        else
            return string
        end
    end

    def pretty_bool_vocational_interview(bool)
        if(bool == true)
            return "Sim"
        elsif(bool == false)
            return "Não"
        elsif(bool == nil)
            return "Não informado"
        else
            return "Não informado"
        end
    end

end
