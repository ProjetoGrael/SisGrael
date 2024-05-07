module Academic::SubjectsHelper
    def subject_leveled_options
        [["Comum", false], ["Nivelada", true]]
    end

    def pretty_subject_leveled(subject)
        if subject.leveled
            'Nivelada'
        else
            'Comum'
        end
    end
end
