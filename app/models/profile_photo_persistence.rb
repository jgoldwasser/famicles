module ProfilePhotoPersistence
  def profile_photo_data=(data)
    if self.profile_photo.nil?
      self.profile_photo = ProfilePhoto.new(data)
    else
      self.profile_photo.update_attributes(data)
    end
  end
end