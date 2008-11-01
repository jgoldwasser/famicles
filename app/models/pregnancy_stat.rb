class PregnancyStat < ActiveRecord::Base
  belongs_to :prearrival
  
  validates_presence_of :prearrival
  validates_presence_of :date

  
end
