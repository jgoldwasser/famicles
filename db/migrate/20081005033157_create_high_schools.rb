class CreateHighSchools < ActiveRecord::Migration
  def self.up
    create_table :high_schools do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :high_schools
  end
end
