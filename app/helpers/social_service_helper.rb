module SocialServiceHelper
  def is_professionalized_student?(student)
    bool = false
    if student != nil
      student.classrooms.where(school_year: Academic::SchoolYear.current).each do |classroom|
        if classroom.professionalized?
          bool = true
        end
      end
    end
    return bool
  end
end
