class Photo < ActiveRecord::Base
  acts_as_taggable_on :tags, :pre_arrival_infos
  
  has_attachment :max_size => 5.megabytes, :content_type => :image, :storage => :file_system, :resize_to => '320x200>', :thumbnails => {:thumb => '150x150>', :geometry => '250x250>'}, :path_prefix => "public/images/profiles"
  validates_as_attachment

  belongs_to :attachable, :polymorphic => true
end
# == Schema Info
# Schema version: 20081011041853
#
# Table name: photos
#
#  id           :integer(4)      not null, primary key
#  parent_id    :integer(4)
#  profile_id   :integer(4)      not null
#  content_type :string(255)     not null, default("")
#  filename     :string(255)     not null, default("")
#  height       :integer(4)
#  size         :integer(4)      not null
#  thumbnail    :string(255)
#  width        :integer(4)
#  created_at   :datetime
#  updated_at   :datetime

