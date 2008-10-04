class InstantMessageAccount < ActiveRecord::Base
  validates_presence_of :contact_info_id
  validates_presence_of :name
  validates_presence_of :provider

end
