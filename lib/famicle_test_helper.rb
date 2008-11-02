module FamicleTestHelper
  TEST_DIR = "tmp/test_images"
  
  def create_famicle(creator, name=creator.name + "'s Famcile")
    famicle = Famicle.create!(:name => name, :public => ApplicationController::PUBLIC)
    creator.famicle_memberships.create!(:famicle_id => famicle.id, :role => "creator", :default => true)
    famicle
  end

  def add_member_to_famicle(famicle, member, role)
    member.famicle_memberships.create!(:famicle_id => famicle.id, :role => role, :default => true)
  end

  def create_relationship_type(options = {})
    RelationshipType.create({ :name => 'Friend', :value => "friend" }.merge(options))
  end

  def create_profile_for_user(user, options = {})
    Profile.new({:user => user, :timezone => "Pacific Time (US & Canada)", :gender => Profile::MALE, :full_name => "Tommy Bahama", :birthdate => 20.years.ago, :public_birthdate_display => Profile::PUBLIC_BIRTHDATE_DISPLAY_FULL, :public => ApplicationController::PUBLIC})
  end

  def create_prearrival
    famicle = create_famicle(@user)

    @child = Child.create!(:famicle => famicle, :name => "Jack", :gender => Child::MALE, :public => ApplicationController::PUBLIC)
    @prearrival = Prearrival.create!(:child => @child, :fetus_nickname => "Bean", :conception_date => 2.months.ago)
  end

  def setup_user_with_profile
    @user = create_user

    @user.activate!
    @profile = create_profile_for_user(@user)
    @profile.contact_info = ContactInfo.new({:profile => @profile})
    @profile.contact_info.email_addresses.build(:contact_info => @profile.contact_info, :email => @user.email, :validated => true, :default => true)
    @profile.save
    @user.profile = @profile
  end
end
