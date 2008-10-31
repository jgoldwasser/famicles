require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Prearrival do
  before(:each) do
    @valid_attributes = {
      :child_id => "1",
      :due_date => Date.today,
      :nursery_theme => "value for nursery_theme",
      :baby_shower_date => Date.today,
      :how_we_found_out => "value for how_we_found_out"
    }
  end

  it "should create a new instance given valid attributes" do
    Prearrival.create!(@valid_attributes)
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

