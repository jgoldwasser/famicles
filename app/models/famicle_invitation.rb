class FamicleInvitation < ActiveRecord::Base
  include AasmFamicleInvitation
  validates_presence_of :sender_id
  validates_presence_of :famicle_id

  belongs_to :receiver, :class_name => "User", :foreign_key => :receiver_id
  belongs_to :sender, :class_name => "User", :foreign_key => :sender_id
  belongs_to :famicle

  after_create :set_invitation_code

  named_scope :pending, lambda { |sender_id, receiver_id| { :conditions => ["state = 'pending' OR state = 'created' AND sender_id = ? AND receiver_id = ?", sender_id, receiver_id] } }

  private

  def set_invitation_code
    self.invitation_code = secure_digest(Time.now, (1..10).map{ rand.to_s })
  end

  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end
end
