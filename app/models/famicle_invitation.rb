class FamicleInvitation < ActiveRecord::Base
  validates_presence_of :sender_id
  validates_presence_of :famicle_id

  include AASM
  aasm_column :state
  aasm_initial_state :initial => :created
  aasm_state :created
  aasm_state :user_invited, :enter => :invite_user
  aasm_state :pending
  aasm_state :accepted,  :enter => :do_accept
  aasm_state :denied,  :enter => :do_deny

  aasm_event :wait_for_repsonse do
    transitions :from => :created, :to => :pending
  end
  aasm_event :send_invite do
    transitions :from => :created, :to => :user_invited
  end
  aasm_event :accept do
    transitions :from => :pending, :to => :accepted
  end

  aasm_event :deny do
    transitions :from => :pending, :to => :denied
  end

  after_create :create_invitation_code

  def self.invite!(famicle, sender, receiver_email)
    if famicle.owners.include?(sender) == false
      raise Exception.new("Only owners of famicles may invite members")
    end

    # Check to see if receiver_email is already a registered user
    receiver = User.find_by_email(receiver_email)
    invitation = FamicleInvitation.create!({:famicle_id => famicle.id, :sender_id => sender.id, :receiver_id => receiver.nil? ? 'null' : receiver.id, :email => receiver_email, :state => "created"})

    if receiver.nil?
      invitation.send_invite!
    else
      invitation.wait_for_repsonse!
    end
    invitation
  end

  def do_accept
    member.famicle_memberships.create!(:famicle_id => famicle.id, :role => role, :default => true)
  end

  protected
  def invite_user
    send_invitation
  end

  def send_invitation
    #TODO send email
  end
  private

  def create_invitation_code
    self.invitation_code = secure_digest(Time.now, (1..10).map{ rand.to_s })
  end

  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end
end
