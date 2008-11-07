module TaggedPhotos

private  
  def update_photo(tag, data, context=nil)    
    if self.photos.tagged_with(tag, :on => context).empty?
      photo = Photo.new(data)
      photo.send("#{context}_list=", tag) unless context.blank?
      self.photos << photo
    else
      self.photos.tagged_with(tag, :on => context).first.update_attributes(data)
    end
  end

  def get_photo(tag, context=nil)
    photos.tagged_with(tag, :on => context).first
  end
end