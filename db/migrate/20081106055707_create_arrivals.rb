class CreateArrivals < ActiveRecord::Migration
  def self.up
    create_table :arrivals do |t|
      t.integer :child_id, :null => false
      t.string :named_after, :limit => 25
      t.string :almost_named, :limit => 25
      t.datetime :born_at
      t.date :due_date
      t.string :place, :limit => 100
      t.integer :weight_pounds
      t.integer :weight_ounces
      t.decimal :height_inches
      t.decimal :head_inches
      t.integer :apgar_score
      t.string :eye_color, :limit => 20
      t.string :hair_color, :limit => 20
      t.string :blood_type, :limit => 5
      t.string :birthmarks
      t.string :delivery_dr_name, :limit => 25
      t.string :ob_dr_name, :limit => 25
      t.integer :birth_style
      t.string :drugs_during_birth
      t.time :labor_time
      t.integer :hospital_days
      t.string :birth_story, :limit => 2000

      t.timestamps
    end
  end

  def self.down
    drop_table :arrivals
  end
end
