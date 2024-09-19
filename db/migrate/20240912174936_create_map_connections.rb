class CreateMapConnections < ActiveRecord::Migration[7.2]
  def change
    create_table :map_connections do |t|
      t.references :map, null: false, foreign_key: { to_table: :maps }
      t.references :connected_map, null: false, foreign_key: { to_table: :maps }

      t.timestamps
    end

    add_index :map_connections, [:map_id, :connected_map_id], unique: true
  end
end
