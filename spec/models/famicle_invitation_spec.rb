require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper
include FamicleTestHelper

describe FamicleInvitation do
  before(:each) do
    @valid_attributes = {
      :sender_id => "1",
      :receiver_id => "1",
      :email => "value for email",
      :state => "value for state",
      :invitation_code => "value for invitation_code",
      :famicle_id => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    FamicleInvitation.create!(@valid_attributes)
  end

  it "should not create a new instance without valid attributes" do
    FamicleInvitation.create(@valid_attributes.except(:sender_id)).save.should eql(false)
    FamicleInvitation.create(@valid_attributes.except(:famicle_id)).save.should eql(false)
  end

  describe "inviting a member" do
    before(:each) do
      @creator = create_user({:login => "creator"})
      @owner = create_user({:login => "owner1"})
      @member = create_user({:login => "member"})
      @famicle = create_famicle(@creator)
      add_member_to_famicle(@famicle, @owner, "owner")
      add_member_to_famicle(@famicle, @member, "member")
    end

    it "should only be allowed by an owner" do
      @other_user = create_user({:login => "invited", :email => "invited@example.com"})
      lambda {@famicle.invite_member_by_email(@owner, @other_user.email)}.should_not raise_error
      lambda {@famicle.invite_member_by_email(@creator, @other_user.email)}.should_not raise_error
      lambda {@famicle.invite_member_by_email(@member, @other_user.email)}.should raise_error
    end

    it "should not change the number of members" do
      lambda {
        @other_user = create_user({:login => "invited", :email => "invited@example.com"})
        @famicle.invite_member_by_email(@owner, @other_user.email)
      }.should_not change(@famicle.members, :count)
    end

    it "should add a famicle membership invitation to invited" do
      @other_user = create_user({:login => "invited", :email => "invited@example.com"})
      lambda {
        @famicle.invite_member_by_email(@owner, @other_user.email)
      }.should change(@other_user.received_invitations, :count).by(1)
    end

    it "should add a famicle invitation to the list of invites for sender" do
      @other_user = create_user({:login => "invited", :email => "invited@example.com"})
      lambda {
        @famicle.invite_member_by_email(@owner, @other_user.email)
      }.should change(@owner.sent_invitations, :count).by(1)
    end

    it "should allow aninvite to a non registered user" do
      lambda {
        @famicle.invite_member_by_email(@owner, "unreg@example.com")
      }.should change(FamicleInvitation, :count).by(1)
    end

    it "should create an invitation with a code" do
      @other_user = create_user({:login => "invited", :email => "invited@example.com"})
      invite = @famicle.invite_member_by_email(@owner, @other_user.email)
      invite.invitation_code.should_not be_nil
    end

    it "should not create a duplicate invitation" do
      @other_user = create_user({:login => "invited", :email => "invited@example.com"})
      invite = @famicle.invite_member_by_email(@owner, @other_user.email)
      lambda {
        @famicle.invite_member(@owner, @other_user)
      }.should_not change(FamicleInvitation, :count)
    end

  end

  describe "accepting an invitation" do
    before(:each) do
      @creator = create_user({:login => "creator"})
      @owner = create_user({:login => "owner1"})
      @member = create_user({:login => "member"})
      @famicle = create_famicle(@creator)
      add_member_to_famicle(@famicle, @owner, "owner")
      add_member_to_famicle(@famicle, @member, "member")
    end
    
    it "should increase the number of members for the famicle" do
      @other_user = create_user({:login => "invited", :email => "invited@example.com"})
      invite = @famicle.invite_member_by_email(@owner, @other_user.email)
      invite.invitation_code.should_not be_nil
      lambda {
        invite.accept!
      }.should change(@famicle.members, :count).by(1)
    end

  end
end
