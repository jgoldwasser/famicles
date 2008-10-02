class CreateFamicleMemberships < ActiveRecord::Migration
  def self.up
    create_table :famicle_memberships do |t|
      t.integer :user_id, :famicle_id, :null => false
      t.string :role, :null => false
      t.boolean :default, :null => false, :default => false

      t.timestamps
    end
    add_index :famicle_memberships, :user_id
    add_index :famicle_memberships, :famicle_id
  end

  def self.down
    drop_table :famicle_memberships
  end
end
