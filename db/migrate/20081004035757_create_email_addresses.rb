class CreateEmailAddresses < ActiveRecord::Migration
  def self.up
    create_table :email_addresses do |t|
      t.integer :contact_info_id, :null => false
      t.string :email, :null => false
      t.boolean :validated, :null => false
      t.boolean :default, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :email_addresses
  end
end
