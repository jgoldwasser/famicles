require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper
include FamicleTestHelper

describe FamiclesController do
  integrate_views

  before(:each) do
    setup_user_with_profile
    FamiclesController.any_instance.stubs(:login_required).returns(true)
    FamiclesController.any_instance.stubs(:current_user).returns(@user)
  end

  it 'should send to famicle profile after save' do
    lambda do
      create_famicle
      assigns[:famicle].should_not be_new_record
      response.should redirect_to(famicle_path(assigns[:famicle]))
    end.should change(Famicle, :count).by(1)
  end

  it "should re-render new template on failed save"  do
    Famicle.any_instance.stubs(:save).returns(false)
    create_famicle
    assigns[:famicle].should be_new_record
    flash[:notice].should be_nil
    response.should render_template("new")
  end


  def create_famicle(options = {})
    post :create, {:famicle => {
        :name => "Goldwassers",
        :description => "Living large in Las Vegas",
        :public => ApplicationController::PUBLIC }}
  end

end
