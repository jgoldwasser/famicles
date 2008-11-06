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
# Schema version: 20081031044850
#
# Table name: photos
#
#  id              :integer(4)      not null, primary key
#  attachable_id   :integer(4)
#  parent_id       :integer(4)
#  attachable_type :string(255)
#  content_type    :string(255)     not null, default("")
#  filename        :string(255)     not null, default("")
#  height          :integer(4)
#  size            :integer(4)      not null
#  thumbnail       :string(255)
#  width           :integer(4)
#  created_at      :datetime
#  updated_at      :datetime

