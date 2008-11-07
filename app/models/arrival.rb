class Arrival < ActiveRecord::Base
  include VirtualModelAttributes
  include TaggedPhotos

  belongs_to :child

  has_many :photos, :as => :attachable, :dependent => :destroy

  PHOTO_CONTEXT = "arrival"

  # Photo Virutal Data Attributes
  def birth_announcement_data=(data) update_photo("birth_announcement", data, PHOTO_CONTEXT); end
  def first_picture_data=(data) update_photo("first_picture", data, PHOTO_CONTEXT); end
  def nursery_photo_data=(data) update_photo("nursery", data, PHOTO_CONTEXT); end

  # Photo Methods
  def birth_announcement_photo() get_photo("birth_announcement", PHOTO_CONTEXT); end
  def first_picture_photo() get_photo("first_picture", PHOTO_CONTEXT); end
  def nursery_photo() get_photo("nursery", PHOTO_CONTEXT); end

end
