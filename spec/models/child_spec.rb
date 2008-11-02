require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include FamicleTestHelper

describe Child do
  before(:each) do
    @valid_attributes = {
      :famicle_id => 1,
      :name => "value for name",
      :nickname => "value for nickname",
      :birthdate => Date.today,
      :gender => Child::MALE,
      :not_born => false,
      :public => ApplicationController::PUBLIC
    }
  end

  it "should create a new instance given valid attributes" do
    Child.create!(@valid_attributes)
  end

  it "should not create a new instance with invalid attributes" do
    Child.create(@valid_attributes.except(:famicle_id)).save.should eql(false)
    Child.create(@valid_attributes.except(:name)).save.should eql(false)
    Child.create(@valid_attributes.except(:public)).save.should eql(false)
    Child.create(@valid_attributes.except(:gender)).save.should eql(false)
  end

  it "should create a new instance with only required attributes" do
    Child.create(@valid_attributes.except(:birthdate)).save.should eql(true)
  end
end
# == Schema Info
# Schema version: 20081031044850
#
# Table name: children
#
#  id         :integer(4)      not null, primary key
#  famicle_id :integer(4)
#  birthdate  :date
#  gender     :integer(1)      not null
#  name       :string(50)
#  nickname   :string(50)
#  not_born   :boolean(1)
#  public     :integer(1)      not null
#  created_at :datetime
#  updated_at :datetime

