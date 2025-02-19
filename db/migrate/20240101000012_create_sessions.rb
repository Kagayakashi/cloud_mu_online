class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.references :user, foreign_key: { on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end
