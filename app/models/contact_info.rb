class ContactInfo < ActiveRecord::Base
  validates_presence_of :profile_id

  belongs_to :profile
  has_many :email_addresses, :dependent => :destroy


  def initialize_default_email
    email_addresses << EmailAddress.create!(:contact_info => self, :email => profile.user.email, :validated => true, :default => true)
  end

end
