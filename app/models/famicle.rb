class Famicle < ActiveRecord::Base
  validates_presence_of :name

  has_many :famicle_memberships
  has_one :creator, :through => :famicle_memberships, :source => :user, :conditions => ["famicle_memberships.role = 'creator'"]
  has_many :members, :through => :famicle_memberships, :source => :user
  has_many :owners, :through => :famicle_memberships, :source => :user, :conditions => ["famicle_memberships.role = 'creator' OR famicle_memberships.role = 'owner'"]

  named_scope :public, :conditions => {:public => true}
  named_scope :private, :conditions => {:public => false}


end
