class CreateInstantMessageAccounts < ActiveRecord::Migration
  def self.up
    create_table :instant_message_accounts do |t|
      t.integer :contact_info_id, :null => false
      t.string :name, :null => false
      t.string :provider, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :instant_message_accounts
  end
end
