require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper
include FamicleTestHelper

describe Famicle do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    Famicle.create!(@valid_attributes)
  end

  it "should not create a new instance without a name" do
    Famicle.create(@valid_attributes.except(:name)).save.should eql(false)
  end

  it "should create a new instance without a description" do
    Famicle.create(@valid_attributes.except(:description)).save.should eql(true)
  end

  describe "creating a new famicle" do
    before(:each) do
      @creating_famicle = lambda do
        @user = create_user
        violated "#{@user.errors.full_messages.to_sentence}" if @user.new_record?
        @famicle = create_famicle(@user)
      end
    end

    it "should have only one member" do
      @creating_famicle.call
      @famicle.members.size.should eql(1)
    end

    it "should have a creator" do
      @creating_famicle.call
      @famicle.creator.should_not be_nil
    end

    it "should default to public" do
      @creating_famicle.call
      @famicle.public.should eql(true)
    end

    it "should have one owner" do
      @creating_famicle.call
      @famicle.owners.size.should eql(1)
    end
  end

  describe "managing and finding members" do
    before(:each) do
      @creator = create_user({:login => "creator"})
      @owner = create_user({:login => "owner1"})
      @member = create_user({:login => "member"})
      @famicle = create_famicle(@creator)
      add_member_to_famicle(@famicle, @owner, "owner")
      add_member_to_famicle(@famicle, @member, "member")
    end

    it "should find all members" do
      @famicle.members.size.should eql(3)
    end

    it "should filter members by owner" do
      @famicle.owners.count.should eql(2)
    end

    it "should filter by creator" do
      @famicle.creator.should_not be_nil
      @famicle.creator.id.should eql(@creator.id)
    end

    it "should not allow the creator to be removed"
    
    it "should allow finding a member by id"
      #@famicle.members.find_by_user_id(@member.id).size.should eql(3)
      #@famicle.members(:user_id => @member.id).should eql(@member)

    it "should reduce the total members" do
      membership = @famicle.famicle_memberships.find_by_user_id(@member.id)
      @famicle.famicle_memberships.delete(membership)
      @famicle.members.count.should eql(2)
    end

  end

end
# == Schema Info
# Schema version: 20081007031845
#
# Table name: famicles
#
#  id          :integer(4)      not null, primary key
#  description :text
#  name        :string(255)     not null, default("")
#  public      :boolean(1)      not null, default(TRUE)
#  created_at  :datetime
#  updated_at  :datetime

