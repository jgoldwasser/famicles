class Child < ActiveRecord::Base
  
  validates_presence_of :famicle_id
  validates_presence_of :name
  validates_inclusion_of :public, :in => [ApplicationController::PUBLIC, ApplicationController::PRIVATE]


  belongs_to :famicle
  has_one :prearrival, :dependent => :destroy

  has_attached_file :photo, :styles => { :small => "150x150", :medium => "200x200" },
                    :url => "/assets/child_photos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/child_photos/:id/:style/:basename.:extension"

  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']



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

