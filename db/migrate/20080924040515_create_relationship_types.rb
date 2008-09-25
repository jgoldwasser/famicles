class CreateRelationshipTypes < ActiveRecord::Migration
  def self.up
    create_table :relationship_types do |t|
      t.string :name, :value, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :relationship_types
  end
end
