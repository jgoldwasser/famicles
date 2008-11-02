require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper
include FamicleTestHelper

describe CollegeAttendance do
  before(:each) do
    setup_user_with_profile
    @valid_attributes = {
      :profile => @user.profile,
      :college => College.create!(:name => "Cal Poly"),
      :class_year => "1",
      :major => "value for major"
    }
  end

  it "should create a new instance given valid attributes" do
    CollegeAttendance.create!(@valid_attributes)
  end

  it "should not create a new instance without a required attributes" do
    CollegeAttendance.create(@valid_attributes.except(:profile)).save.should eql(false)
    CollegeAttendance.create(@valid_attributes.except(:college)).save.should eql(false)
  end

  it "should allow a school attendance to be added without a year" do
    CollegeAttendance.create(@valid_attributes.except(:class_year)).save.should eql(true)
    CollegeAttendance.create(@valid_attributes.except(:major)).save.should eql(true)
  end
end
# == Schema Info
# Schema version: 20081031044850
#
# Table name: college_attendances
#
#  id         :integer(4)      not null, primary key
#  college_id :integer(4)      not null
#  profile_id :integer(4)      not null
#  class_year :integer(4)
#  major      :string(255)
#  created_at :datetime
#  updated_at :datetime

