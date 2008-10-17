module ProfilesHelper
  def add_high_school_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :high_school_attendances, :partial => "high_school_attendance", :object => HighSchoolAttendance.new
    end
  end

  def add_college_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :college_attendances, :partial => "college_attendance", :object => CollegeAttendance.new
    end
  end
end
