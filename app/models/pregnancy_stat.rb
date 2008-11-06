class PregnancyStat < ActiveRecord::Base
  belongs_to :prearrival
  
  validates_presence_of :prearrival
  validates_presence_of :date

  
end
# == Schema Info
# Schema version: 20081105063617
#
# Table name: pregnancy_stats
#
#  id                  :integer(4)      not null, primary key
#  prearrival_id       :integer(4)      not null
#  baby_heartrate      :integer(4)
#  blood_pressure      :integer(4)
#  date                :date            not null
#  stomach_measurement :integer(10)
#  week                :integer(4)
#  weight              :integer(10)
#  weight_gain         :integer(10)
#  created_at          :datetime
#  updated_at          :datetime

