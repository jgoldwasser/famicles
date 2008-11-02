class Prearrival < ActiveRecord::Base
  belongs_to :child

  has_many :photos, :as => :attachable, :dependent => :destroy
  has_many :pregnancy_stats, :dependent => :destroy

  after_update :save_pregnancy_stats

  def belly_photo_data=(data) update_photo("belly", data); end
  def nursery_photo_data=(data) update_photo("nursery", data); end
  def first_baby_photo_data=(data) update_photo("first_baby", data); end

  def belly_photo() get_photo("belly"); end
  def nursery_photo() get_photo("nursery"); end
  def first_baby_photo() get_photo("first_baby"); end

  def existing_pregnancy_stat_attributes=(attributes) set_existing_model_attributes(:pregnancy_stats, "pregnancy_stat", PregnancyStat, attributes); end
  def new_pregnancy_stat_attributes=(attributes) set_new_model_attributes(:pregnancy_stats, attributes); end
  
private
  def update_photo(tag, data)
    if self.photos.tagged_with(tag, :on => :pre_arrival_infos).empty?
      photo = Photo.new(data)
      photo.pre_arrival_info_list = tag
      self.photos << photo
    else
      self.photos.tagged_with(tag, :on => :pre_arrival_infos).first.update_attributes(data)
    end
  end

  def get_photo(tag)
    photos.tagged_with(tag, :on => :pre_arrival_infos).first
  end

  def set_new_model_attributes(name, model_attributes)
    model_attributes.each do |attributes|
      send(name).build(attributes.merge({:prearrival => self}))
    end
  end

  def set_existing_model_attributes(name, sub_model, sub_model_class, model_attributes)
    send(name).reject(&:new_record?).each do |model|
      attributes = model_attributes[model.id.to_s]
      if attributes
        model.attributes = attributes
      else
        send(name).delete(model)
      end
    end
  end

  def save_pregnancy_stats
    pregnancy_stats.each do |stat|
      stat.save(false)
    end
  end

end
# == Schema Info
# Schema version: 20081031044001
#
# Table name: prearrivals
#
#  id               :integer(4)      not null, primary key
#  child_id         :integer(4)
#  baby_shower_date :date
#  due_date         :date
#  fetus_nickname   :string(50)
#  how_we_found_out :string(2000)
#  nursery_theme    :string(255)
#  created_at       :datetime
#  updated_at       :datetime

