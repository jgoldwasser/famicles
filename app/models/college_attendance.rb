class CollegeAttendance < ActiveRecord::Base
  validates_presence_of :profile_id
  validates_presence_of :college_id

  belongs_to :profile
  belongs_to :college
end
