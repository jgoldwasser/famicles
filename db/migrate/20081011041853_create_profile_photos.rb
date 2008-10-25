class CreateProfilePhotos < ActiveRecord::Migration
  def self.up
    create_table :profile_photos do |t|
      t.integer :profile_id
      t.integer :parent_id
      t.integer :attachable_id
      t.string :attachable_type
      t.string :content_type, :null => false
      t.string :filename, :null => false
      t.string :thumbnail
      t.integer :size, :null => false
      t.integer :width
      t.integer :height

      t.timestamps
    end
    add_index :profile_photos, :parent_id
    add_index :profile_photos, [:attachable_id, :attachable_type]
  end

  def self.down
    drop_table :profile_photos
  end
end
