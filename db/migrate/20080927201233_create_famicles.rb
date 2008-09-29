class CreateFamicles < ActiveRecord::Migration
  def self.up
    create_table :famicles do |t|
      t.string :name, :null => false
      t.text :description
      t.boolean :public, :null => false, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :famicles
  end
end
