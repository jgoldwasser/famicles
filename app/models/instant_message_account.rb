class InstantMessageAccount < ActiveRecord::Base
  validates_presence_of :contact_info_id
  validates_presence_of :name
  validates_presence_of :provider

end
# == Schema Info
# Schema version: 20081031044850
#
# Table name: instant_message_accounts
#
#  id              :integer(4)      not null, primary key
#  contact_info_id :integer(4)      not null
#  name            :string(255)     not null, default("")
#  provider        :string(255)     not null, default("")
#  created_at      :datetime
#  updated_at      :datetime

