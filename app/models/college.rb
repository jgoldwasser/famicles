class College < ActiveRecord::Base
  validates_presence_of :name
end
# == Schema Info
# Schema version: 20081105063617
#
# Table name: colleges
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)     not null, default("")
#  created_at :datetime
#  updated_at :datetime

