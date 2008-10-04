class EmailAddress < ActiveRecord::Base
  validates_presence_of :contact_info_id
  validates_presence_of :email

  belongs_to :contact_info

end
