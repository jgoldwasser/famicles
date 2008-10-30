module PhotoPersistence
  def photo_data=(data)
    if self.photo.nil?
      self.photo = Photo.new(data)
    else
      self.photo.update_attributes(data)
    end
  end
end