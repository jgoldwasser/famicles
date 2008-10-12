require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper
include FamicleTestHelper

describe ProfileController, "creating a new profile" do
  integrate_views

  before(:each) do
    Profile.any_instance.stubs(:birthdate).returns(20.years.ago.to_date)
  end

  it "should redirect to index with a notice on successful save" do
    lambda do
      create_profile
      assigns[:profile].should_not be_new_record
      flash[:notice].should_not be_nil
      response.should redirect_to(profiles_path)
    end.should change(Profile, :count).by(1)
  end

  it "should re-render new tempalte on failed save"  do
    Profile.any_instance.stubs(:save).returns(false)
    post 'create'
    assigns[:profile].should be_new_record
    flash[:notice].should be_nil
    response.should render_template("new")
  end

  def create_profile(options = {})
    @user = create_user

    post :create, :profile => { :user => @user,

        :timezone => "Pacific Time (US & Canada)",
        :gender => Profile::MALE,
        :full_name => "Tommy Bahama",
        :birthdate => 20.years.ago,
        :public_birthdate_display => Profile::PUBLIC_BIRTHDATE_DISPLAY_FULL,
        :gender_public => true }.merge(options)
  end

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

end
