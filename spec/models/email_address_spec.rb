require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include FamicleTestHelper

describe EmailAddress do
  before(:each) do
    @valid_attributes = {
      :contact_info => mock_contact_info,
      :email => "value for email",
      :validated => false,
      :default => false
    }
  end

  it "should create a new instance given valid attributes" do
    EmailAddress.create!(@valid_attributes)
  end

  it "should not create an instance without valid attributes" do
    EmailAddress.create(@valid_attributes.except(:contact_info)).save.should eql(false)
    EmailAddress.create(@valid_attributes.except(:email)).save.should eql(false)
  end

  describe 'cleanup after profile deletion' do
    it 'should remove all email addresses'
  end
end
# == Schema Info
# Schema version: 20081105063617
#
# Table name: email_addresses
#
#  id              :integer(4)      not null, primary key
#  contact_info_id :integer(4)      not null
#  default         :boolean(1)      not null
#  email           :string(255)     not null, default("")
#  validated       :boolean(1)      not null
#  created_at      :datetime
#  updated_at      :datetime

