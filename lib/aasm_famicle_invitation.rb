module AasmFamicleInvitation
  unless Object.constants.include? "STATEFUL_ROLES_CONSTANTS_DEFINED"
    STATEFUL_ROLES_CONSTANTS_DEFINED = true # sorry for the C idiom
  end

  def self.included( recipient )
    recipient.extend( StatefulFamicleInvitationClassMethods )
    recipient.class_eval do
      include StatefulFamicleInvitationInstanceMethods
      include AASM
      aasm_column :state
      aasm_initial_state :initial => :created
      aasm_state :created
      aasm_state :user_invited, :enter => :invite_user  # When invited is not already registered
      aasm_state :pending                               # User is registered, waiting for for accept or deny
      aasm_state :accepted,  :enter => :do_accept
      aasm_state :denied,  :enter => :do_deny

      aasm_event :wait_for_repsonse do
        transitions :from => [:created, :user_invited], :to => :pending
      end
      aasm_event :send_invite do
        transitions :from => :created, :to => :user_invited
      end
      aasm_event :accept do
        transitions :from => [:pending, :user_invited], :to => :accepted, :guard => Proc.new {|i| !i.receiver_id.blank?}
      end

      aasm_event :deny do
        transitions :from => :pending, :to => :denied
      end
    end
  end

  module StatefulFamicleInvitationClassMethods
  end # class methods

  module StatefulFamicleInvitationInstanceMethods
    def do_accept
      famicle.handle_invitation_acceptance(self)
      self.accepted_at = DateTime.now
      save
    end

    def invite_user
      send_invitation
    end

    def send_invitation
      #TODO send email
    end
    # Returns true if the user has just been activated.
#    def recently_activated?
#      @activated
#    end
#    def do_delete
#      self.deleted_at = Time.now.utc
#    end
#
#    def do_activate
#      @activated = true
#      self.activated_at = Time.now.utc
#      self.deleted_at = self.activation_code = nil
#    end
  end # instance methods
end