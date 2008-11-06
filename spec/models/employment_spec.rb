require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper
include FamicleTestHelper

describe Employment do
  before(:each) do
    setup_user_with_profile
    @valid_attributes = {
      :profile => @user.profile,
      :employer => Employer.create!(:name => "Viant"),
      :position => "value for position",
      :location => "value for location",
      :start => "value for start",
      :end => "value for end",
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    Employment.create!(@valid_attributes)
  end

  it "should not create a new instance without a required attributes" do
    Employment.create(@valid_attributes.except(:profile)).save.should eql(false)
    Employment.create(@valid_attributes.except(:employer)).save.should eql(false)
  end

  it "should allow a school attendance to be added without a year" do
    Employment.create(@valid_attributes.except(:position)).save.should eql(true)
    Employment.create(@valid_attributes.except(:location)).save.should eql(true)
    Employment.create(@valid_attributes.except(:start)).save.should eql(true)
    Employment.create(@valid_attributes.except(:end)).save.should eql(true)
    Employment.create(@valid_attributes.except(:description)).save.should eql(true)
  end
end
# == Schema Info
# Schema version: 20081105063617
#
# Table name: employments
#
#  id          :integer(4)      not null, primary key
#  employer_id :integer(4)      not null
#  profile_id  :integer(4)      not null
#  description :string(500)
#  end         :string(20)
#  location    :string(50)
#  position    :string(100)
#  start       :string(20)
#  created_at  :datetime
#  updated_at  :datetime

