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
# == Schema Info
# Schema version: 20081004035902
#
# Table name: instant_message_accounts
#
#  id              :integer(4)      not null, primary key
#  contact_info_id :integer(4)      not null
#  name            :string(255)     not null, default("")
#  provider        :string(255)     not null, default("")
#  created_at      :datetime
#  updated_at      :datetime

