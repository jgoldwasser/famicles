class HighSchoolAttendance < ActiveRecord::Base
  validates_presence_of :profile_id
  validates_presence_of :high_school_id

  belongs_to :profile
  belongs_to :high_school
end
