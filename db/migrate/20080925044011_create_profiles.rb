class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id, :null => false
      t.string :full_name, :null => false, :limit => 50
      t.integer :gender, :null => false, :limit => 1
      t.boolean :gender_public, :default => true
      t.date :birthdate, :null => false
      t.integer :public_birthdate_display, :null => false, :limit => 1
      t.string :timezone, :null => false, :limit => 50
      t.string :hometown, :political_view, :religious_view, :parenting_style, :limit => 100
      t.string :about_me, :what_i_like, :what_i_do, :favorite_tv, :favorite_music, :favorite_sites, :favorite_movies, :limit => 2000                                                      
      t.boolean :public, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
