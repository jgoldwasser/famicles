class ContactInfo < ActiveRecord::Base
  validates_presence_of :profile
  validates_associated :email_addresses

  belongs_to :profile
  has_many :email_addresses, :dependent => :destroy

  after_update :save_emails
  
  def existing_email_address_attributes=(email_attributes)
    email_addresses.reject(&:new_record?).each do |email|
      attributes = email_attributes[email.id.to_s]
      if attributes
        email.attributes = attributes
      else
        email_addresses.delete(email)
      end
    end
  end

  def new_email_address_attributes=(email_attributes)
    email_attributes.each do |attributes|
      email_addresses.build(attributes.merge({:default => false, :validated => false}))
    end
  end

  def save_emails
    email_addresses.each do |email|
      email.save(false)
    end
  end
end
# == Schema Info
# Schema version: 20081031044001
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

