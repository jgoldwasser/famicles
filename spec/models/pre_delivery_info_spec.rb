require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PreDeliveryInfo do
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
    PreDeliveryInfo.create!(@valid_attributes)
  end
end
