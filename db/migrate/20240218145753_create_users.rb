class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, null: false, index: { unique: true, name: 'unique_usernames' }
      t.string :email, null: false, index: { unique: true, name: 'unique_emails' }
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
