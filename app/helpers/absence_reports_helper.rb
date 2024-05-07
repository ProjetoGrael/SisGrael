module AbsenceReportsHelper

    def pretty_key(key)
        Student.human_attribute_name(key)
    end

end
