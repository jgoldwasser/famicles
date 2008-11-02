require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HighSchool do
  before(:each) do
    @valid_attributes = {
      :name => "Santana"
    }
  end

  it "should create a new instance given valid attributes" do
    HighSchool.create!(@valid_attributes)
  end

  it "should not create without a name" do
    HighSchool.create(@valid_attributes.except(:name)).save.should eql(false)
  end
end
# == Schema Info
# Schema version: 20081031044850
#
# Table name: high_schools
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)     not null, default("")
#  created_at :datetime
#  updated_at :datetime

