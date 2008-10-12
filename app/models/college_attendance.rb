class CollegeAttendance < ActiveRecord::Base
  validates_presence_of :profile_id
  validates_presence_of :college_id

  belongs_to :profile
  belongs_to :college
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

