class CreatePregnancyStats < ActiveRecord::Migration
  def self.up
    create_table :pregnancy_stats do |t|
      t.integer :prearrival_id, :null => false
      t.date :date, :null => false
      t.integer :week
      t.decimal :weight
      t.decimal :weight_gain
      t.integer :blood_pressure
      t.decimal :stomach_measurement
      t.integer :baby_heartrate

      t.timestamps
    end
  end

  def self.down
    drop_table :pregnancy_stats
  end
end
