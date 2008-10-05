class CreateCollegeAttendances < ActiveRecord::Migration
  def self.up
    create_table :college_attendances do |t|
      t.integer :profile_id, :null => false
      t.integer :college_id, :null => false
      t.integer :class_year
      t.string :major

      t.timestamps
    end
  end

  def self.down
    drop_table :college_attendances
  end
end
