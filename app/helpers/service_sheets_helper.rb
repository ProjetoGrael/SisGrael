module ServiceSheetsHelper


    def marital_status_options
        ServiceSheet.marital_statuses.keys
    end

    def working_situation_options
        ServiceSheet.working_situations.keys
    end

    def residence_status_options
        ServiceSheet.residence_statuses.keys
    end

    def kind_of_residence_options
        ServiceSheet.kind_of_residences.keys
    end

    def get_position(service_sheet)
    
        year = service_sheet.created_at.nil? ?  Date.today.year : service_sheet.created_at.strftime("%Y")
        
        @service_sheets = ServiceSheet.where("created_at >= ?", "#{year}-01-01")
        counter = 0
        found = false
        while counter < @service_sheets.length && !found
            ss = @service_sheets[counter]
            counter += 1
            if ss.id == service_sheet.id
                found = true
            end
        end

        return found ? "#{counter}/#{year}" : "#{counter + 1}/#{year}"
    end

    def dont_print_nil(string)
        if(string == nil or string == "")
            return "-"
        else
            return string
        end
    end
    
    def pretty_bool_service_sheet(bool)
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
