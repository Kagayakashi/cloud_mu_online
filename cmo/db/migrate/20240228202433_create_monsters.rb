class CreateMonsters < ActiveRecord::Migration[7.1]
  def change
    create_table :monsters do |t|
      t.string :name, null: false
      t.integer :level, null: false
      t.integer :health, null: false
      t.integer :min_attack, null: false
      t.integer :max_attack, null: false
      t.integer :attack_rate, null: false
      t.integer :defense_rate, null: false
      t.integer :defense, null: false
      t.integer :experience, null: false
      t.integer :spawn_time, null: false

      t.timestamps
    end
  end
end
