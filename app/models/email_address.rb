class EmailAddress < ActiveRecord::Base
  validates_presence_of :contact_info
  validates_presence_of :email

  belongs_to :contact_info

end
# == Schema Info
# Schema version: 20081031044850
#
# Table name: email_addresses
#
#  id              :integer(4)      not null, primary key
#  contact_info_id :integer(4)      not null
#  default         :boolean(1)      not null
#  email           :string(255)     not null, default("")
#  validated       :boolean(1)      not null
#  created_at      :datetime
#  updated_at      :datetime

