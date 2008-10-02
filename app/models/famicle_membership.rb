class FamicleMembership < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :famicle_id
  validates_presence_of :role

  belongs_to :famicle, :dependent => :destroy
  belongs_to :user, :dependent => :destroy


  def to_s
    "id: #{id}, famicle_id: #{famicle_id}, user_id: #{user_id}, role: #{role}, default: #{default}"
  end
end
