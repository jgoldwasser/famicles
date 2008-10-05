require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CollegeAttendance do
  before(:each) do
    @valid_attributes = {
      :profile_id => "1",
      :college_id => "1",
      :class_year => "1",
      :major => "value for major"
    }
  end

  it "should create a new instance given valid attributes" do
    CollegeAttendance.create!(@valid_attributes)
  end

  it "should not create a new instance without a required attributes" do
    CollegeAttendance.create(@valid_attributes.except(:profile_id)).save.should eql(false)
    CollegeAttendance.create(@valid_attributes.except(:college_id)).save.should eql(false)
  end

  it "should allow a school attendance to be added without a year" do
    CollegeAttendance.create(@valid_attributes.except(:class_year)).save.should eql(true)
    CollegeAttendance.create(@valid_attributes.except(:major)).save.should eql(true)
  end
end
