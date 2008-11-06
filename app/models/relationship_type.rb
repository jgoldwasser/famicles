class RelationshipType < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :value
  validates_uniqueness_of :value

end

# == Schema Info
# Schema version: 20081105063617
#
# Table name: relationship_types
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)     not null, default("")
#  value      :string(255)     not null, default("")
#  created_at :datetime
#  updated_at :datetime

