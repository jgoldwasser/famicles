class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :attachable_id
      t.string :attachable_type
      t.string :image_file_name
      t.string :image_content_type
      t.string :image_file_size
      t.string :image_updated_at

      t.timestamps
    end
    add_index :photos, [:attachable_id, :attachable_type]
  end

  def self.down
    drop_table :photos
  end
end
