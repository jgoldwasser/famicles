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
  
end
