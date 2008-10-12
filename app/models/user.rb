require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::AasmRoles

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :email, :name, :password, :password_confirmation



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    u = find_in_state :first, :active, :conditions => {:email => email} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end


  # Famicles additons below here

  has_many :relationships, :dependent => :destroy
  has_many :famicle_memberships, :dependent => :destroy
  has_many :received_invitations, :class_name => "FamicleInvitation", :foreign_key => :receiver_id, :dependent => :destroy
  has_many :sent_invitations, :class_name => "FamicleInvitation", :foreign_key => :sender_id, :dependent => :destroy
  has_one :default_famicle, :through => :famicle_memberships, :source => :famicle, :conditions => ["famicle_memberships.default = 1"]
  has_many :famicles, :through => :famicle_memberships, :source => :famicle
  has_one :profile, :dependent => :destroy

  def accept_invitation_code(code)
    invite = FamicleInvitation.find_by_invitation_code(code)
    return if invite.blank?
    
    invite.receiver_id = self.id
    invite.save
    invite.accept!
  end

  protected

  def assign_invitation_matches
    matches = FamicleInvitation.find_all_by_email(email)
    matches.each do |invite|
      invite.receiver = self
      invite.save
      invite.wait_for_repsonse!
    end
  end
  
  def make_activation_code
        self.deleted_at = nil
        self.activation_code = self.class.make_token
    end


end
# == Schema Info
# Schema version: 20081011041853
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  activation_code           :string(40)
#  crypted_password          :string(40)
#  email                     :string(100)
#  name                      :string(100)     default("")
#  remember_token            :string(40)
#  salt                      :string(40)
#  state                     :string(255)     default("passive")
#  activated_at              :datetime
#  created_at                :datetime
#  deleted_at                :datetime
#  remember_token_expires_at :datetime
#  updated_at                :datetime

