class CreateEmployments < ActiveRecord::Migration
  def self.up
    create_table :employments do |t|
      t.integer :profile_id, :null => false
      t.integer :employer_id, :null => false
      t.string :position, :limit => 100
      t.string :location, :limit => 50
      t.string :start, :limit => 20
      t.string :end, :limit => 20
      t.string :description, :limit => 500

      t.timestamps
    end
  end

  def self.down
    drop_table :employments
  end
end
