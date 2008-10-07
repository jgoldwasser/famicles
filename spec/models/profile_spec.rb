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

  describe 'managing schools and jobs' do
    before(:each) do
      @user = create_user
      @user.activate!
      @profile = create_profile_for_user(@user)
      @user.profile = @profile
    end

    it 'should allow adding and deleting high schools' do
      @profile.high_schools.count.should eql(0)
      adding_high_school(@profile, "Santana").should change(@profile.high_schools, :count).by(1)
      adding_high_school(@profile, "West Hills").should change(@profile.high_schools, :count).by(1)
      @profile.high_schools.count.should eql(2)
      @profile.high_school_attendances.first.destroy
      @profile.high_schools.count.should eql(1)
      HighSchool.count.should eql(2)
    end

    it 'should allow adding and removing colleges' do
      @profile.colleges.count.should eql(0)
      adding_college(@profile, "Cal Poly").should change(@profile.colleges, :count).by(1)
      adding_college(@profile, "Grossmont").should change(@profile.colleges, :count).by(1)
      @profile.colleges.count.should eql(2)
      @profile.college_attendances.first.destroy
      @profile.colleges.count.should eql(1)
      College.count.should eql(2)
    end

    it 'should allow adding and removing jobs' do
      @profile.employers.count.should eql(0)
      adding_employer(@profile, "Starbucks").should change(@profile.employers, :count).by(1)
      adding_employer(@profile, "Home Depot").should change(@profile.employers, :count).by(1)
      @profile.employers.count.should eql(2)
      @profile.employments.first.destroy
      @profile.employers.count.should eql(1)
      Employer.count.should eql(2)
    end

    it 'should remove college attendance when profile is deleted' do
      adding_college(@profile, "Cal Poly").call
      adding_college(@profile, "Grossmont").call
      lambda {@profile.destroy}.should change(CollegeAttendance, :count).by(-2)
      College.count.should eql(2)
    end

    it 'should remove high school attendance when profile is deleted' do
      adding_high_school(@profile, "Cal Poly").call
      adding_high_school(@profile, "Grossmont").call
      lambda {@profile.destroy}.should change(HighSchoolAttendance, :count).by(-2)
      HighSchool.count.should eql(2)
    end

    it 'should remove employment when profile is deleted' do
      adding_employer(@profile, "Starbucks").call
      adding_employer(@profile, "Home Depot").call
      lambda {@profile.destroy}.should change(Employment, :count).by(-2)
      Employer.count.should eql(2)
    end
  end

private
  def adding_college(profile, college_name)
    lambda do
      school = College.create!(:name => college_name)
      CollegeAttendance.create!(:profile => profile, :college => school)
    end
  end

  def adding_high_school(profile, school_name)
    lambda do
      school = HighSchool.create!(:name => school_name)
      HighSchoolAttendance.create!(:profile => profile, :high_school => school)
    end
  end

  def adding_employer(profile, employer_name)
    lambda do
      employer = Employer.create!(:name => employer_name)
      Employment.create!(:profile => profile, :employer => employer)
    end
  end

end
# == Schema Info
# Schema version: 20081005033651
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

