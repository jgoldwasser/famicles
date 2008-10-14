class HighSchoolAttendance < ActiveRecord::Base
  validates_presence_of :profile
  validates_presence_of :high_school

  belongs_to :profile
  belongs_to :high_school

  def high_school_data=(attributes)
    self.high_school = HighSchool.find_or_initialize_by_name(attributes)
  end
end
# == Schema Info
# Schema version: 20081011041853
#
# Table name: high_school_attendances
#
#  id             :integer(4)      not null, primary key
#  high_school_id :integer(4)      not null
#  profile_id     :integer(4)      not null
#  class_year     :integer(4)
#  created_at     :datetime
#  updated_at     :datetime

