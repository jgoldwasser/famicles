class Child < ActiveRecord::Base
  validates_presence_of :famicle_id
  validates_presence_of :name

  validates_inclusion_of :public, :in => [ApplicationController::PUBLIC, ApplicationController::PRIVATE]
end
