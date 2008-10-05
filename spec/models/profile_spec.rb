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

  describe 'managing high schools' do
    before(:each) do
      @user = create_user
      @user.activate!
      @profile = create_profile_for_user(@user)
      @user.profile = @profile
    end

    it 'should allow adding and deleting high schools' do
      @profile.high_schools.count.should eql(0)
      lambda {
        hs = HighSchool.create!(:name => "Santana")
        HighSchoolAttendance.create!(:profile => @profile, :high_school => hs)
      }.should change(@profile.high_schools, :count).by(1)

      hs2 = HighSchool.create!(:name => "West Hills")
      HighSchoolAttendance.create!(:profile => @profile, :high_school => hs2)
      @profile.high_schools.count.should eql(2)

      

    end

    it 'should allow removing highschools' 
  end


end
# == Schema Info
# Schema version: 20081004035902
#
# Table name: profiles
#
#  id                       :integer(4)      not null, primary key
#  user_id                  :integer(4)      not null
#  about_me                 :string(2000)
#  birthdate                :date            not null
#  favorite_movies          :string(2000)
#  favorite_music           :string(2000)
#  favorite_sites           :string(2000)
#  favorite_tv              :string(2000)
#  full_name                :string(50)      not null, default("")
#  gender                   :integer(1)      not null
#  gender_public            :boolean(1)      default(TRUE)
#  hometown                 :string(100)
#  parenting_style          :string(100)
#  political_view           :string(100)
#  public                   :boolean(1)      default(TRUE)
#  public_birthdate_display :integer(1)      not null
#  religious_view           :string(100)
#  timezone                 :string(50)      not null, default("")
#  what_i_do                :string(2000)
#  what_i_like              :string(2000)
#  created_at               :datetime
#  updated_at               :datetime

