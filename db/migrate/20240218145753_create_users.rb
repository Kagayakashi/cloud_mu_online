class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.datetime :last_login_at
      t.boolean :is_guest, null: false, default: true

      t.timestamps
    end
  end
end
