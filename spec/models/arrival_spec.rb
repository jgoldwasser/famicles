require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Arrival do
  before(:each) do
    @valid_attributes = {
      :child_id => "1",
      :named_after => "value for named_after",
      :almost_named => "value for almost_named",
      :born_at => Time.now,
      :due_date => Date.today,
      :place => "value for place",
      :weight_pounds => "1",
      :weight_ounces => "1",
      :height_inches => "9.99",
      :head_inches => "9.99",
      :apgar_score => "1",
      :eye_color => "value for eye_color",
      :hair_color => "value for hair_color",
      :blood_type => "value for blood_type",
      :birthmarks => "value for birthmarks",
      :delivery_dr_name => "value for delivery_dr_name",
      :ob_dr_name => "value for ob_dr_name",
      :birth_style => "1",
      :drugs_during_birth => "value for drugs_during_birth",
      :labor_time => Time.now,
      :hospital_days => "1",
      :birth_story => "value for birth_story"
    }
  end

  it "should create a new instance given valid attributes" do
    Arrival.create!(@valid_attributes)
  end
end
