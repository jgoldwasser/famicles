require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FamicleMembership do
  before(:each) do
    @valid_attributes = {
      :user_id => "1",
      :famicle_id => "1",
      :role => "creator",
      :default => true
    }
  end

  it "should create a new instance given valid attributes" do
    FamicleMembership.create!(@valid_attributes)
  end

  it "should not create a new instance without a required attributes" do
    FamicleMembership.create(@valid_attributes.except(:user_id)).save.should eql(false)
    FamicleMembership.create(@valid_attributes.except(:famicle_id)).save.should eql(false)
    FamicleMembership.create(@valid_attributes.except(:role)).save.should eql(false)
    FamicleMembership.create(@valid_attributes.except(:default)).save.should eql(false)
  end

  it "should create a new instance with out required attributes" do
    FamicleMembership.create(@valid_attributes.except(:state)).save.should eql(true)
  end

  
end