require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include FamicleTestHelper

describe Child do
  before(:each) do
    @valid_attributes = {
      :famicle_id => 1,
      :name => "value for name",
      :birthdate => Date.today,
      :born => true,
      :public => ApplicationController::PUBLIC,
      :tracked => false
    }
  end

  it "should create a new instance given valid attributes" do
    Child.create!(@valid_attributes)
  end

  it "should not create a new instance with invalid attributes" do
    Child.create(@valid_attributes.except(:famicle_id)).save.should eql(false)
    Child.create(@valid_attributes.except(:name)).save.should eql(false)
    Child.create(@valid_attributes.except(:public)).save.should eql(false)
  end

  it "should create a new instance with only required attributes" do
    Child.create(@valid_attributes.except(:birthdate)).save.should eql(true)
  end
end
