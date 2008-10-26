class Child < ActiveRecord::Base
  include ProfilePhotoPersistence
  
  validates_presence_of :famicle_id
  validates_presence_of :name
  validates_inclusion_of :public, :in => [ApplicationController::PUBLIC, ApplicationController::PRIVATE]

  belongs_to :famicle
  has_one :profile_photo, :as => :attachable, :dependent => :destroy
end
