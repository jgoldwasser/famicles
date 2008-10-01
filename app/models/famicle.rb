class Famicle < ActiveRecord::Base
  validates_presence_of :name

  has_many :famicle_memberships
  has_one :creator, :through => :famicle_memberships, :source => :user, :conditions => ["famicle_memberships.role = 'creator'"]
  has_many :members, :through => :famicle_memberships, :source => :user
  has_many :owners, :through => :famicle_memberships, :source => :user, :conditions => ["famicle_memberships.role IN ('creator', 'owner')"]

  named_scope :public, :conditions => {:public => true}
  named_scope :private, :conditions => {:public => false}
  
  def invite_member_by_email(sender, receiver_email)
    raise Exception.new("Only Owners can invite members") unless invitation_allowed?(sender)
    receiver = User.find_by_email(receiver_email)

    if receiver.blank?
      invitation = FamicleInvitation.create!({:famicle => self, :sender => sender, :email => receiver_email, :state => "created"})
      invitation.send_invite!
    else
      invitation = invite_member(sender, receiver)
    end

    invitation
  end

  def invite_member(sender, receiver)
    raise Exception.new("Only Owners can invite members") unless invitation_allowed?(sender)
    matches = FamicleInvitation.pending(sender.id, receiver.id)

    if matches.blank?
      invitation = FamicleInvitation.create!({:famicle => self, :sender => sender, :receiver => receiver, :email => receiver.email, :state => "created"})
      invitation.wait_for_repsonse!
    else
      invitation = matches.first
    end

    invitation
  end
  
private
  def invitation_allowed?(sender)
    owners.include?(sender)
  end
end
