class ContactInfo < ActiveRecord::Base
  validates_presence_of :profile_id

  belongs_to :profile
  has_many :email_addresses, :dependent => :destroy


  def initialize_default_email
    email_addresses << EmailAddress.create!(:contact_info => self, :email => profile.user.email, :validated => true, :default => true)
  end

end
# == Schema Info
# Schema version: 20081004035902
#
# Table name: contact_infos
#
#  id           :integer(4)      not null, primary key
#  profile_id   :integer(4)      not null
#  address      :string(255)
#  city         :string(50)
#  land_phone   :string(20)
#  mobile_phone :string(20)
#  postal_code  :string(20)
#  state        :string(50)
#  websites     :string(500)
#  created_at   :datetime
#  updated_at   :datetime

