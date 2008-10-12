class FamicleInvitation < ActiveRecord::Base
  include AasmFamicleInvitation
  validates_presence_of :sender_id
  validates_presence_of :famicle_id

  belongs_to :receiver, :class_name => "User", :foreign_key => :receiver_id
  belongs_to :sender, :class_name => "User", :foreign_key => :sender_id
  belongs_to :famicle

  before_create :set_invitation_code

  named_scope :pending, :conditions => {:state => "pending"}

  private

  def set_invitation_code
    self.invitation_code = secure_digest(Time.now, (1..10).map{ rand.to_s })
  end

  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end
end
# == Schema Info
# Schema version: 20081011041853
#
# Table name: famicle_invitations
#
#  id              :integer(4)      not null, primary key
#  famicle_id      :integer(4)      not null
#  receiver_id     :integer(4)
#  sender_id       :integer(4)      not null
#  email           :string(255)
#  invitation_code :string(255)
#  state           :string(255)     not null, default("created")
#  accepted_at     :datetime
#  created_at      :datetime
#  declined_at     :datetime
#  sent_at         :datetime
#  updated_at      :datetime

