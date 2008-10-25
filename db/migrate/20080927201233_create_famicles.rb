class CreateFamicles < ActiveRecord::Migration
  def self.up
    create_table :famicles do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :public, :null => false, :limit => 1
      t.text :hometown
      t.text :most_resemble

      t.timestamps
    end
  end

  def self.down
    drop_table :famicles
  end
end
