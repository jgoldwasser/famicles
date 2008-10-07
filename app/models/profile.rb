class Profile < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :full_name
  validates_presence_of :birthdate
  validates_presence_of :gender
  validates_presence_of :timezone

  PUBLIC_BIRTHDATE_DISPLAY_FULL = 1
  PUBLIC_BIRTHDATE_DISPLAY_MONTH_YEAR = 2
  PUBLIC_BIRTHDATE_DISPLAY_NONE = 3
  validates_inclusion_of :public_birthdate_display, :in => [PUBLIC_BIRTHDATE_DISPLAY_FULL, PUBLIC_BIRTHDATE_DISPLAY_MONTH_YEAR, PUBLIC_BIRTHDATE_DISPLAY_NONE]

  belongs_to :user
  has_one :contact_info, :dependent => :destroy
  has_many :high_school_attendances, :dependent => :destroy
  has_many :college_attendances, :dependent => :destroy
  has_many :high_schools, :through => :high_school_attendances, :source => :high_school
  has_many :colleges, :through => :college_attendances, :source => :college
  has_many :employments, :dependent => :destroy
  has_many :employers, :through => :employments, :source => :employer

  after_create :setup_models

  MALE = 0
  EMALE = 1



private
  def setup_models
    self.contact_info =  ContactInfo.create!(:profile => self)
    self.contact_info.initialize_default_email
  end
end
# == Schema Info
# Schema version: 20081007031845
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

