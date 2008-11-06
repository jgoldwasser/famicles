class Photo < ActiveRecord::Base
  acts_as_taggable_on :tags, :pre_arrival_infos

  has_attached_file :image, :styles => { :small => "150x150", :medium => "200x200" },
                    :url => "/assets/photos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"

  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

  belongs_to :attachable, :polymorphic => true
end
# == Schema Info
# Schema version: 20081105063617
#
# Table name: photos
#
#  id                 :integer(4)      not null, primary key
#  attachable_id      :integer(4)
#  attachable_type    :string(255)
#  image_content_type :string(255)
#  image_file_name    :string(255)
#  image_file_size    :string(255)
#  created_at         :datetime
#  image_updated_at   :string(255)
#  updated_at         :datetime

