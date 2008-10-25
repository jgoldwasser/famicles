class CreateFamiclePhotos < ActiveRecord::Migration
  def self.up
    create_table :famicle_photos do |t|
      t.integer :famicle_id
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
    drop_table :famicle_photos
  end
end
