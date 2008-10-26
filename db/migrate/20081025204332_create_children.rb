class CreateChildren < ActiveRecord::Migration
  def self.up
    create_table :children do |t|
      t.integer :famicle_id
      t.string :name
      t.date :birthdate
      t.boolean :not_born
      t.integer :public, :null => false, :limit => 1
      t.boolean :tracked

      t.timestamps
    end
  end

  def self.down
    drop_table :children
  end
end
