class CreateFamicleInvitations < ActiveRecord::Migration
  def self.up
    create_table :famicle_invitations do |t|
      t.integer :famicle_id, :null => false
      t.integer :sender_id, :null => false
      t.integer :receiver_id
      t.string :email
      t.string :state, :null => false, :default => "created"
      t.string :invitation_code
      t.datetime :sent_at, :accepted_at, :declined_at

      t.timestamps
    end
  end

  def self.down
    drop_table :famicle_invitations
  end
end
