class Relationship < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :relationship_type_id

  belongs_to :relationship_type
  belongs_to :user
  belongs_to :relative, :class_name => "User", :foreign_key => "related_to_id"
  
  def self.relate_users(inviter, invitee, relationship_type)
    return unless inviter.relationships.find_by_related_to_id(invitee.id).nil?
    inviter.relationships << Relationship.create!({:user_id => inviter.id, :related_to_id => invitee.id, :relationship_type_id => relationship_type.id})
    invitee.relationships << Relationship.create!({:user_id => invitee.id, :related_to_id => inviter.id, :relationship_type_id => relationship_type.id})  
  end

  def self.unrelate_users(user1, user2)
    r1 = user1.relationships.find_by_related_to_id(user2.id)
    r2 = user2.relationships.find_by_related_to_id(user1.id)
    r1.destroy
    r2.destroy
  end

end
# == Schema Info
# Schema version: 20081105063617
#
# Table name: relationships
#
#  id                   :integer(4)      not null, primary key
#  related_to_id        :integer(4)      not null
#  relationship_type_id :integer(4)      not null
#  user_id              :integer(4)      not null
#  created_at           :datetime
#  updated_at           :datetime

