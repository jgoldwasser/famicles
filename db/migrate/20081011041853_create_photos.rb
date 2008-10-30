class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
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
    add_index :photos, :parent_id
    add_index :photos, [:attachable_id, :attachable_type]
  end

  def self.down
    drop_table :photos
  end
end
