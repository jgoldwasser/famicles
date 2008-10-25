class FamiclePhoto < ActiveRecord::Base
  has_attachment :max_size => 5.megabytes, :content_type => :image, :storage => :file_system, :resize_to => '320x200>', :thumbnails => {:thumb => '150x150>', :geometry => '250x250>'}, :path_prefix => "public/images/profiles"
  validates_as_attachment

  belongs_to :famicle
end
