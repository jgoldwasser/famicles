class CreateContactInfos < ActiveRecord::Migration
  def self.up
    create_table :contact_infos do |t|
      t.integer :profile_id, :null => false
      t.string :address
      t.string :city, :limit => 50
      t.string :state, :limit => 50
      t.string :postal_code, :limit => 20
      t.string :land_phone, :limit => 20
      t.string :mobile_phone, :limit => 20
      t.string :websites, :limit => 500
      #TODO Add fields needed for permissions on this data
      t.timestamps
    end
  end

  def self.down
    drop_table :contact_infos
  end
end
