require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper
include FamicleTestHelper

describe HighSchoolAttendance do
  before(:each) do
    setup_user_with_profile
    @valid_attributes = {
      :profile => @user.profile,
      :high_school => HighSchool.create!(:name => "Santana"),
      :class_year => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    HighSchoolAttendance.create!(@valid_attributes)
  end

  it "should not create a new instance without a required attributes" do
    HighSchoolAttendance.create(@valid_attributes.except(:profile)).save.should eql(false)
    HighSchoolAttendance.create(@valid_attributes.except(:high_school)).save.should eql(false)
  end

  it "should allow a school attendance to be added without a year" do
    HighSchoolAttendance.create(@valid_attributes.except(:class_year)).save.should eql(true)
  end

end
# == Schema Info
# Schema version: 20081105063617
#
# Table name: high_school_attendances
#
#  id             :integer(4)      not null, primary key
#  high_school_id :integer(4)      not null
#  profile_id     :integer(4)      not null
#  class_year     :integer(4)
#  created_at     :datetime
#  updated_at     :datetime

