require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper
include FamicleTestHelper

describe ChildrenController do
  integrate_views

  before(:each) do
    setup_user_with_profile
    @famicle = create_famicle(@user)
    ChildrenController.any_instance.stubs(:login_required).returns(true)
    ChildrenController.any_instance.stubs(:current_user).returns(@user)
  end

  it 'should send to child profile after save' do
    lambda do
      create_child
      assigns[:child].should_not be_new_record
      response.should redirect_to(famicle_child_path(assigns[:child].famicle, assigns[:child]))
    end.should change(Child, :count).by(1)
  end

  it "should re-render new template on failed save"  do
    Child.any_instance.stubs(:save).returns(false)
    create_child
    assigns[:child].should be_new_record
    flash[:notice].should be_nil
    response.should render_template("new")
  end


  def create_child(options = {})
    post :create, {:famicle_id => @famicle.id, :child => {
        :famicle_id => @famicle.id,
        :name => "Jack",
        :gender => Child::MALE,
        :not_born => false,
        :public => ApplicationController::PUBLIC }}
  end
end
