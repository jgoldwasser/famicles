class Profile < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :full_name
  validates_presence_of :birthdate
  validates_presence_of :gender
  validates_presence_of :timezone

  validates_associated :contact_info
  validates_associated :high_school_attendances

  PUBLIC_BIRTHDATE_DISPLAY_FULL = 1
  PUBLIC_BIRTHDATE_DISPLAY_MONTH_YEAR = 2
  PUBLIC_BIRTHDATE_DISPLAY_NONE = 3
  validates_inclusion_of :public_birthdate_display, :in => [PUBLIC_BIRTHDATE_DISPLAY_FULL, PUBLIC_BIRTHDATE_DISPLAY_MONTH_YEAR, PUBLIC_BIRTHDATE_DISPLAY_NONE]

  belongs_to :user
  has_one :contact_info, :dependent => :destroy
  has_one :profile_photo, :dependent => :destroy
  has_many :high_school_attendances, :dependent => :destroy
  has_many :college_attendances, :dependent => :destroy
  has_many :employments, :dependent => :destroy

  # Through Relationships
  has_many :high_schools, :through => :high_school_attendances, :source => :high_school
  has_many :colleges, :through => :college_attendances, :source => :college
  has_many :employers, :through => :employments, :source => :employer


  after_update :save_attendances

  MALE = 0
  FEMALE = 1

  # Virtual Attributes - these are used to save collections and models belonging to a profile
  def contact_info_data=(attributes)
    if contact_info.nil?
      self.contact_info = ContactInfo.new(attributes.merge(:profile => self))
      self.contact_info.email_addresses.build(:contact_info => self.contact_info, :email => self.user.email, :validated => true, :default => true)
    else
      self.contact_info.update_attributes(attributes)
    end
  end

  def new_high_school_attendance_attributes=(hs_attributes)
    hs_attributes.each do |attributes|
      high_school_attendances.build(attributes.merge({:profile => self}))
    end
  end

  def existing_high_school_attendance_attributes=(hs_attributes)
    high_school_attendances.reject(&:new_record?).each do |attendance|
      attributes = hs_attributes[attendance.id.to_s]
      if attributes
        attendance.attributes = attributes
        attendance.high_school = HighSchool.find_or_initialize_by_name(attributes[:hs_name])
      else
        high_school_attendances.delete(attendance)
      end
    end
  end

  private

  def save_attendances
    high_school_attendances.each do |attendance|
      attendance.save(false)
    end
  end
end
# == Schema Info
# Schema version: 20081011041853
#
# Table name: profiles
#
#  id                       :integer(4)      not null, primary key
#  user_id                  :integer(4)      not null
#  about_me                 :string(2000)
#  birthdate                :date            not null
#  favorite_movies          :string(2000)
#  favorite_music           :string(2000)
#  favorite_sites           :string(2000)
#  favorite_tv              :string(2000)
#  full_name                :string(50)      not null, default("")
#  gender                   :integer(1)      not null
#  gender_public            :boolean(1)      default(TRUE)
#  hometown                 :string(100)
#  parenting_style          :string(100)
#  political_view           :string(100)
#  public                   :boolean(1)      default(TRUE)
#  public_birthdate_display :integer(1)      not null
#  religious_view           :string(100)
#  timezone                 :string(50)      not null, default("")
#  what_i_do                :string(2000)
#  what_i_like              :string(2000)
#  created_at               :datetime
#  updated_at               :datetime

