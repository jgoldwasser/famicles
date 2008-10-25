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

  def add_employer_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :employments, :partial => "employment", :object => Employment.new
    end
  end

  def add_email_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :email_addresses, :partial => "email_address", :object => EmailAddress.new
    end
  end

  def birthdate_display_options
    [
        ["Display Full Birthdate", Profile::PUBLIC_BIRTHDATE_DISPLAY_FULL],
        ["Display Month and Year", Profile::PUBLIC_BIRTHDATE_DISPLAY_MONTH_YEAR ],
        ["Do not display", Profile::PUBLIC_BIRTHDATE_DISPLAY_NONE ]
    ]
  end

  def gender_options
    [["Male", 1], ["Female", 0]]
  end
end
