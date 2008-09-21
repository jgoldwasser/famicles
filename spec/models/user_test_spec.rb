require File.join(File.dirname(__FILE__), *%w[../spec_helper])


describe User do
  before(:each) do
    @user = User.new
  end

  it "should have a name" do
    @user.name = "Joe"
    @user.name.should == "Joe"
  end

  it "should have an email" do
    @user.name = "joe"
    @user.email = "joe@mjg2.com"
    
    @user.email.should_not be_nil
  end
end