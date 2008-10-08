require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper


describe Relationship do
  before(:each) do
    @valid_attributes = {
      :user_id => "1",
      :related_to_id => "1",
      :relationship_type_id => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    Relationship.create!(@valid_attributes)
  end

  it "should require both a user and type" do
    Relationship.create(@valid_attributes.except(:user_id)).save.should eql(false)
    Relationship.create(@valid_attributes.except(:relationship_type_id)).save.should eql(false)
  end

protected
  def create_relationship(options)
    Relationship.new(options)
  end
end

describe Relationship, ".link between two users" do
  before(:each) do
    @user1 = create_user(:email => "user1@example.com")
    @user2 = create_user(:email => "user2@example.com")

    @friend = create_relationship_type(:name => "Friend", :value => "friend")
    @mom = create_relationship_type(:name => "Mom", :value => "mother")
    @son = create_relationship_type(:name => "Son", :value => "son")
  end
  
  it "should create two new relationships" do
    lambda {
      Relationship.relate_users(@user1, @user2, @friend)
    }.should change(Relationship, :count).by(2)
  end

  it "should add friend type to each if friend chosen" do
    Relationship.relate_users(@user1, @user2, @friend)
    relationship_type = @user1.relationships.find_by_related_to_id(@user2.id).relationship_type
    relationship_type.value.should eql("friend")
    relationship_type = @user2.relationships.find_by_related_to_id(@user1.id).relationship_type
    relationship_type.value.should eql("friend")
  end

  it "should not allow two relationships between the same users" do
    Relationship.relate_users(@user1, @user2, @friend)
    lambda {
      Relationship.relate_users(@user1, @user2, @friend)
    }.should_not change(Relationship, :count)
  end

  it "should be managed properly when unlinking" do
    Relationship.relate_users(@user1, @user2, @friend)
    lambda {
      Relationship.unrelate_users(@user1, @user2)
    }.should change(Relationship, :count).by(-2)                                            
  end

  it "should add mother/son properly" # Note requires profile setup so that we can determine sex of inviter


end
# == Schema Info
# Schema version: 20081007031845
#
# Table name: relationships
#
#  id                   :integer(4)      not null, primary key
#  related_to_id        :integer(4)      not null
#  relationship_type_id :integer(4)      not null
#  user_id              :integer(4)      not null
#  created_at           :datetime
#  updated_at           :datetime

