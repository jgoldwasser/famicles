require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper

describe Profile do
  before(:each) do
    @valid_attributes = {
        :full_name => "Curt Zee",
        :hometown => "Las Vegas",
        :gender => "0",
        :birthdate => 23.years.ago,
        :about_me => "value for about_me",
        :timezone => "Pacific Time (US & Canada)"
    }
  end

  it "should create a new instance given valid attributes" do
    Profile.create!(@valid_attributes)
  end

  it "should not create a new instance with invalid attributes" do
    Profile.create(@valid_attributes.except(:full_name)).save.should eql(false)
    Profile.create(@valid_attributes.except(:gender)).save.should eql(false)
    Profile.create(@valid_attributes.except(:birthdate)).save.should eql(false)
    Profile.create(@valid_attributes.except(:timezone)).save.should eql(false)
    
  end

  it "should create a new instance with only required attributes" do
    Profile.create(@valid_attributes.except(:hometown, :about_me)).save.should eql(true)
  end

#  describe 'being initialized from new user' do
#    before(:each) do
#      @creating_user = lambda do
#        @user = create_user
#        violated "#{@user.errors.full_messages.to_sentence}" if @user.new_record?
#      end
#    end
#
#    it 'starts in pending state' do
#      @creating_user.call
#      @user.reload
#      @user.profile.should be_pending
#    end
#  end

  protected
  def create_user(options = {})
    record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.register! if record.valid?
    record
  end
end
