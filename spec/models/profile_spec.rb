require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper
include FamicleTestHelper

describe Profile do
  before(:each) do
    @valid_attributes = {
        :user_id => 1,
        :full_name => "Curt Zee",
        :hometown => "Las Vegas",
        :gender => Profile::MALE,
        :gender_public => true,
        :birthdate => 23.years.ago,
        :public_birthdate_display => 1,
        :about_me => "value for about_me",
        :timezone => "Pacific Time (US & Canada)"
    }
  end

  it "should create a new instance given valid attributes" do
    Profile.create!(@valid_attributes)
  end

  it "should not create a new instance with invalid attributes" do
    Profile.create(@valid_attributes.except(:user_id)).save.should eql(false)
    Profile.create(@valid_attributes.except(:full_name)).save.should eql(false)
    Profile.create(@valid_attributes.except(:birthdate)).save.should eql(false)
    Profile.create(@valid_attributes.except(:gender)).save.should eql(false)
    Profile.create(@valid_attributes.except(:timezone)).save.should eql(false)
  end

  it "should create a new instance with only required attributes" do
    Profile.create(@valid_attributes.except(:hometown, :about_me)).save.should eql(true)
  end

  describe 'being set by a new user' do
    it 'should have one email set as default and activated' do
      user = create_user
      user.activate!
      profile = create_profile_for_user(user)
      user.profile = profile
      user.profile.contact_info.email_addresses.count.should eql(1)
      user.profile.contact_info.email_addresses.first.default.should eql(true)
      user.profile.contact_info.email_addresses.first.validated.should eql(true)
    end
  end

end
