class FamicleMembership < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :famicle
  validates_presence_of :role

  belongs_to :famicle
  belongs_to :user


  def to_s
    "id: #{id}, famicle_id: #{famicle_id}, user_id: #{user_id}, role: #{role}, default: #{default}"
  end
end
# == Schema Info
# Schema version: 20081031044850
#
# Table name: famicle_memberships
#
#  id         :integer(4)      not null, primary key
#  famicle_id :integer(4)      not null
#  user_id    :integer(4)      not null
#  default    :boolean(1)      not null
#  role       :string(255)     not null, default("")
#  created_at :datetime
#  updated_at :datetime

