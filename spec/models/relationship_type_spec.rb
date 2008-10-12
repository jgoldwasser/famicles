require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RelationshipType do
  it "should not allow duplicate names" do
    create_type(:name => "Mom", :value => "mother").save
    lambda {
      create_type(:name => "Mom", :value => "mother").save
    }.should_not change(RelationshipType, :count)
  end

  it "should increment count after creation" do
    lambda {
      create_type.save
    }.should change(RelationshipType, :count).by(1)
  end

  it "should not create an instance without a name" do
    lambda {
      create_type(:name => nil).save
    }.should_not change(RelationshipType, :count)
  end

protected
  def create_type(options = {})
    r = RelationshipType.new({ :name => 'Friend', :value => "friend" }.merge(options))
    r
  end
end


# == Schema Info
# Schema version: 20081011041853
#
# Table name: relationship_types
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)     not null, default("")
#  value      :string(255)     not null, default("")
#  created_at :datetime
#  updated_at :datetime

