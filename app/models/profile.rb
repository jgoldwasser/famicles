class Profile < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :full_name
  validates_presence_of :birthdate
  validates_presence_of :gender
  validates_presence_of :timezone

  belongs_to :user
  has_one :contact_info

  after_create :setup_models

  MALE = 0
  EMALE = 1

  PUBLIC_BIRTHDATE_DISPLAY_FULL = 1
  PUBLIC_BIRTHDATE_DISPLAY_MONTH_YEAR = 2
  PUBLIC_BIRTHDATE_DISPLAY_NONE = 3

private
  def setup_models
    self.contact_info =  ContactInfo.create!(:profile => self)
    self.contact_info.initialize_default_email
  end
end
