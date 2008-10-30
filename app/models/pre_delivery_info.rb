class PreDeliveryInfo < ActiveRecord::Base
  belongs_to :child

  has_many :profile_photos, :as => :attachable, :dependent => :destroy

  def belly_photo_data=(data) update_photo("belly", data); end
  def nursery_photo_data=(data) update_photo("nursery", data); end
  def first_baby_photo_data=(data) update_photo("first_baby", data); end

  def belly_photo() get_photo("belly"); end
  def nursery_photo() get_photo("nursery"); end
  def first_baby_photo() get_photo("first_baby"); end

private
  def update_photo(tag, data)
    if self.profile_photos.tagged_with(tag, :on => :pre_arrival_infos).empty?
      photo = ProfilePhoto.new(data)
      photo.pre_arrival_info_list = tag
      self.profile_photos << photo
    else
      self.profile_photos.tagged_with(tag, :on => :pre_arrival_infos).first.update_attributes(data)
    end
  end

  def get_photo(tag)
    profile_photos.tagged_with(tag, :on => :pre_arrival_infos).first
  end

end
