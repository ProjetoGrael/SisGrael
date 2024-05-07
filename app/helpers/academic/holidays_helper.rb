module Academic::HolidaysHelper
  def holiday_school_year_value(holiday)
    if holiday.school_year_id
      holiday.school_year_id
    else
      params[:school_year_id]
    end
  end
end
