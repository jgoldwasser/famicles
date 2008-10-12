class ProfilePhoto < ActiveRecord::Base
  has_attachment :content_type => :image, :storage => :file_system, :resize_to => '320x200>', :thumnails => {:thumb => '100x100>'}
  validates_as_attachment
end
