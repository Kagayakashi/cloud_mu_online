class CreateMonsters < ActiveRecord::Migration[7.1]
  def change
    create_table :monsters do |t|
      t.string :name
      t.integer :level
      t.integer :health
      t.integer :min_attack
      t.integer :max_attack
      t.integer :attack_rate
      t.integer :defense_rate
      t.integer :defense
      t.integer :spawn_time

      t.timestamps
    end
  end
end
