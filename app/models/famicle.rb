class Famicle < ActiveRecord::Base
  validates_presence_of :name

  # Members
  has_many :famicle_memberships
  has_one :creator, :through => :famicle_memberships, :source => :user, :conditions => ["famicle_memberships.role = 'creator'"]
  has_many :members, :through => :famicle_memberships, :source => :user
  has_many :owners, :through => :famicle_memberships, :source => :user, :conditions => ["famicle_memberships.role IN ('creator', 'owner')"]

  # Invitations 
  has_many :famicle_invitations

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
    invitation = famicle_invitations.pending.find_by_sender_id(sender)

    if invitation.blank?
      invitation = FamicleInvitation.create!({:famicle => self, :sender => sender, :receiver => receiver, :email => receiver.email, :state => "created"})
      invitation.wait_for_repsonse!
    end

    invitation
  end

  def handle_invitation_acceptance(invite)
    famicle_memberships.create!(:user => invite.receiver, :role => "member", :default => invite.receiver.famicle_memberships.count == 0)
  end

  private
  def invitation_allowed?(sender)
    owners.include?(sender)
  end
end
# == Schema Info
# Schema version: 20081011041853
#
# Table name: famicles
#
#  id          :integer(4)      not null, primary key
#  description :text
#  name        :string(255)     not null, default("")
#  public      :boolean(1)      not null, default(TRUE)
#  created_at  :datetime
#  updated_at  :datetime

