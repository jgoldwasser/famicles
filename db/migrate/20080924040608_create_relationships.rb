class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :user_id, :related_to_id, :relationship_type_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
