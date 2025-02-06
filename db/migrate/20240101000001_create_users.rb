class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, null: false, index: { unique: true, name: 'unique_user_username' }
      t.string :email, null: false, index: { unique: true, name: 'unique_user_email' }
      t.string :password_digest, null: false
      t.boolean :is_guest, null: false, default: true
      t.datetime :last_login_at

      t.timestamps
    end
  end
end
