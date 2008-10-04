require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InstantMessageAccount do
  before(:each) do
    @valid_attributes = {
      :contact_info_id => "1",
      :name => "value for name",
      :provider => "value for provider"
    }
  end

  it "should create a new instance given valid attributes" do
    InstantMessageAccount.create!(@valid_attributes)
  end

  it "should not create an instance without valid attributes" do
    InstantMessageAccount.create(@valid_attributes.except(:contact_info_id)).save.should eql(false)
    InstantMessageAccount.create(@valid_attributes.except(:name)).save.should eql(false)
    InstantMessageAccount.create(@valid_attributes.except(:provider)).save.should eql(false)
  end

end
