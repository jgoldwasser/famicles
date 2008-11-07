class Prearrival < ActiveRecord::Base
  include VirtualModelAttributes
  include TaggedPhotos
  
  belongs_to :child

  has_many :photos, :as => :attachable, :dependent => :destroy
  has_many :pregnancy_stats, :dependent => :destroy

  after_update :save_pregnancy_stats

  PHOTO_CONTEXT = "prearrival"

  def belly_photo_data=(data) update_photo("belly", data, PHOTO_CONTEXT); end
  def nursery_photo_data=(data) update_photo("nursery", data, PHOTO_CONTEXT); end
  def first_baby_photo_data=(data) update_photo("first_baby", data, PHOTO_CONTEXT); end

  def belly_photo() get_photo("belly", PHOTO_CONTEXT); end
  def nursery_photo() get_photo("nursery", PHOTO_CONTEXT); end
  def first_baby_photo() get_photo("first_baby", PHOTO_CONTEXT); end

  def existing_pregnancy_stat_attributes=(attributes) set_existing_model_attributes(:pregnancy_stats, attributes); end
  def new_pregnancy_stat_attributes=(attributes) set_new_model_attributes(:pregnancy_stats, attributes); end
  
private
  def save_pregnancy_stats
    pregnancy_stats.each do |stat|
      stat.save(false)
    end
  end

end
# == Schema Info
# Schema version: 20081105063617
#
# Table name: prearrivals
#
#  id               :integer(4)      not null, primary key
#  child_id         :integer(4)
#  baby_shower_date :date
#  conception_date  :date
#  due_date         :date
#  fetus_nickname   :string(50)
#  how_we_found_out :string(2000)
#  nursery_theme    :string(255)
#  created_at       :datetime
#  updated_at       :datetime

