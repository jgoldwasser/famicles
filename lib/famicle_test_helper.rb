module FamicleTestHelper
  def create_famicle(creator, name=creator.name + "'s Famcile")
    famicle = Famicle.create!(:name => name)
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
    Profile.create!({:user => user, :timezone => "Pacific Time (US & Canada)", :gender => Profile::MALE, :full_name => "Tommy Bahama", :birthdate => 20.years.ago, :public_birthdate_display => Profile::PUBLIC_BIRTHDATE_DISPLAY_FULL, :gender_public => true})
  end

  def setup_user_with_profile
    @user = create_user
    @user.activate!
    @profile = create_profile_for_user(@user)
    @user.profile = @profile
  end
end
