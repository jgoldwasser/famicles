class CreateHighSchoolAttendances < ActiveRecord::Migration
  def self.up
    create_table :high_school_attendances do |t|
      t.integer :profile_id, :null => false
      t.integer :high_school_id, :null => false
      t.integer :class_year

      t.timestamps
    end
  end

  def self.down
    drop_table :high_school_attendances
  end
end
