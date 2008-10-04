require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper
include FamicleTestHelper

describe ContactInfo do
  before(:each) do
    @valid_attributes = {
      :profile_id => "1",
      :address => "value for address",
      :city => "value for city",
      :state => "value for state",
      :postal_code => "value for postal_code",
      :land_phone => "value for land_phone",
      :mobile_phone => "value for mobile_phone",
      :websites => "www.example.com"
    }
  end

  it "should create a new instance given valid attributes" do
    ContactInfo.create!(@valid_attributes)
  end

  it "should not create an instance without a profile" do
    ContactInfo.create(@valid_attributes.except(:profile_id)).save.should eql(false)
  end

  it "should create an instance without non-required attributes" do
    ContactInfo.create(@valid_attributes.except(:address, :city)).save.should eql(true)
  end

  describe 'cleanup after profile deletion' do
    it 'should remove contact info record'
  end

#  describe 'adding an email address' do
#    contact_info = ContactInfo.create!(@valid_attributes)
#    lambda {
#      contact_info.email_addresses << EmailAddress.build(:email => "email@example.com", :validated => "false", :default => "false")
#    }.should change(contact_info.email_addresses, :count).by(1)
#  end
end
