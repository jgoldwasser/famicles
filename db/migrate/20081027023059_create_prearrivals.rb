class CreatePrearrivals < ActiveRecord::Migration
  def self.up
    create_table :prearrivals do |t|
      t.integer :child_id
      t.string :fetus_nickname, :limit => 50
      t.date :due_date
      t.string :nursery_theme
      t.date :baby_shower_date
      t.string :how_we_found_out, :limit => 2000

      t.timestamps
    end
  end

  def self.down
    drop_table :prearrivals
  end
end
