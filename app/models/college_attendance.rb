class CollegeAttendance < ActiveRecord::Base
  validates_presence_of :profile
  validates_presence_of :college
  attr_accessor :college_name


  belongs_to :profile
  belongs_to :college

  def college_name=(name)
    self.college = College.find_or_initialize_by_name(name)
  end

  def college_name
    self.college.nil? ? "" : self.college.name
  end
end
# == Schema Info
# Schema version: 20081011041853
#
# Table name: college_attendances
#
#  id         :integer(4)      not null, primary key
#  college_id :integer(4)      not null
#  profile_id :integer(4)      not null
#  class_year :integer(4)
#  major      :string(255)
#  created_at :datetime
#  updated_at :datetime

