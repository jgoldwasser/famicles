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

    it "should allow an invite to a non registered user" do
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

  describe "signing up from an invite" do
    before(:each) do
      @creator = create_user({:login => "creator"})
      @famicle = create_famicle(@creator)
    end

    it "should auto accept the invitation" do
      invite = @famicle.invite_member_by_email(@creator, "nonmember@example.com")
      lambda {
        user = create_user(:login => "nonmember", :email => "nonmember@example.com")
        user.activate!
        user.accept_invitation_code(invite.invitation_code)
      }.should change(@famicle.famicle_memberships, :count).by(1)
    end

  end

  describe "handling more than one invite for a non user" do
    before(:each) do
      @creator = create_user({:login => "creator"})
      @famicle = create_famicle(@creator)
      @another_creator = create_user({:login => "creator2"})
      @another_famicle = create_famicle(@another_creator)
      @first_invite = @famicle.invite_member_by_email(@creator, "nonmember@example.com")
      @second_invite = @another_famicle.invite_member_by_email(@another_creator, "nonmember@example.com")
      @new_user = create_user(:login => "nonmember", :email => "nonmember@example.com")
      @new_user.activate!
    end

    it "should show one pending invite from another member when two invites sent from different famicles" do
      @new_user.received_invitations.pending.count.should eql(2)
      @new_user.accept_invitation_code(@first_invite.invitation_code)
      @new_user.famicle_memberships.count.should eql(1)
      @famicle.members.count.should eql(2)
      @another_famicle.members.count.should eql(1)
      @new_user.received_invitations.pending.count.should eql(1)
    end

    it "should create the first invite as default famicle and second as non-default" do
      @new_user.accept_invitation_code(@first_invite.invitation_code)
      @new_user.received_invitations.pending.first.accept!
      @new_user.famicle_memberships.count.should eql(2)
      @new_user.default_famicle.should eql(@famicle)
      @new_user.famicle_memberships.find_by_famicle_id(@another_famicle.id).default.should eql(false)
    end
  end

end
