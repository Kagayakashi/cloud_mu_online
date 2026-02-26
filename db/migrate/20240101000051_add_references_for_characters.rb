class AddReferencesForCharacters < ActiveRecord::Migration[7.2]
  def change
    add_reference :characters, :user, foreign_key: { on_delete: :cascade }
    add_reference :users, :character, foreign_key: { on_delete: :nullify }

    add_reference :characters, :city, foreign_key: { on_delete: :cascade }, null: false
  end
end
