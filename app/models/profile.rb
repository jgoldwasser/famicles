class Profile < ActiveRecord::Base
  validates_presence_of :full_name
  validates_presence_of :gender
  validates_presence_of :birthdate
  validates_presence_of :timezone

end
