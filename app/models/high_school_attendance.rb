class HighSchoolAttendance < ActiveRecord::Base
  validates_presence_of :profile_id
  validates_presence_of :high_school_id

  belongs_to :profile
  belongs_to :high_school
end
# == Schema Info
# Schema version: 20081007031845
#
# Table name: high_school_attendances
#
#  id             :integer(4)      not null, primary key
#  high_school_id :integer(4)      not null
#  profile_id     :integer(4)      not null
#  class_year     :integer(4)
#  created_at     :datetime
#  updated_at     :datetime

