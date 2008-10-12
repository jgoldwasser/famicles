class CreateProfilePhotos < ActiveRecord::Migration
  def self.up
    create_table :profile_photos do |t|
      t.integer :profile_id, :null => false
      t.integer :parent_id
      t.string :content_type, :null => false
      t.string :filename, :null => false
      t.string :thumbnail
      t.integer :size, :null => false
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end

  def self.down
    drop_table :profile_photos
  end
end
