class Employment < ActiveRecord::Base
  validates_presence_of :profile_id
  validates_presence_of :employer_id

  belongs_to :profile
  belongs_to :employer
end
# == Schema Info
# Schema version: 20081011041853
#
# Table name: employments
#
#  id          :integer(4)      not null, primary key
#  employer_id :integer(4)      not null
#  profile_id  :integer(4)      not null
#  description :string(500)
#  end         :string(20)
#  location    :string(50)
#  position    :string(100)
#  start       :string(20)
#  created_at  :datetime
#  updated_at  :datetime

