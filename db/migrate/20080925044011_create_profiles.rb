class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :full_name, :null => false
      t.string :hometown
      t.integer :gender, :null => false
      t.date :birthdate, :null => false
      t.text :about_me
      t.string :timezone, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
