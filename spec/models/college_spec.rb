require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe College do
  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    College.create!(@valid_attributes)
  end

  it "should not create without a name" do
    College.create(@valid_attributes.except(:name)).save.should eql(false)
  end
end
