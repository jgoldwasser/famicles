class HighSchoolAttendance < ActiveRecord::Base
  validates_presence_of :profile
  validates_presence_of :high_school
  attr_accessor :high_school_name

  belongs_to :profile
  belongs_to :high_school

  def high_school_name=(name)
    self.high_school = HighSchool.find_or_initialize_by_name(name)
  end

  def high_school_name
    self.high_school.nil? ? "" : self.high_school.name
  end
end
# == Schema Info
# Schema version: 20081105063617
#
# Table name: high_school_attendances
#
#  id             :integer(4)      not null, primary key
#  high_school_id :integer(4)      not null
#  profile_id     :integer(4)      not null
#  class_year     :integer(4)
#  created_at     :datetime
#  updated_at     :datetime

