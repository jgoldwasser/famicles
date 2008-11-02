class Child < ActiveRecord::Base
  include PhotoPersistence
  
  validates_presence_of :famicle_id
  validates_presence_of :name
  validates_inclusion_of :public, :in => [ApplicationController::PUBLIC, ApplicationController::PRIVATE]


  belongs_to :famicle
  has_one :photo, :as => :attachable, :dependent => :destroy
  has_one :prearrival, :dependent => :destroy

  # Gender Options
  MALE = 0
  FEMALE = 1
  UNKNOWN = 2
  
  validates_inclusion_of :gender, :in => [MALE, FEMALE, UNKNOWN]

  def gender_display
    case gender
    when MALE
      "Male"
    when FEMALE
      "Female"
    when UNKNOWN
      "Not yet known"
    end
  end
end
# == Schema Info
# Schema version: 20081031044850
#
# Table name: children
#
#  id         :integer(4)      not null, primary key
#  famicle_id :integer(4)
#  birthdate  :date
#  gender     :integer(1)      not null
#  name       :string(50)
#  nickname   :string(50)
#  not_born   :boolean(1)
#  public     :integer(1)      not null
#  created_at :datetime
#  updated_at :datetime

