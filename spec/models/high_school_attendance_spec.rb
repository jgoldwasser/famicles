require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HighSchoolAttendance do
  before(:each) do
    @valid_attributes = {
      :profile_id => "1",
      :high_school_id => "1",
      :class_year => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    HighSchoolAttendance.create!(@valid_attributes)
  end

  it "should not create a new instance without a required attributes" do
    HighSchoolAttendance.create(@valid_attributes.except(:profile_id)).save.should eql(false)
    HighSchoolAttendance.create(@valid_attributes.except(:high_school_id)).save.should eql(false)
  end

  it "should allow a school attendance to be added without a year" do
    HighSchoolAttendance.create(@valid_attributes.except(:class_year)).save.should eql(true)
  end

end
