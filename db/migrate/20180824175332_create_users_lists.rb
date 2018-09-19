class CreateUsersLists < ActiveRecord::Migration[5.0]
  def change
    create_table :users_lists do |t|
      t.references :list, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.boolean :is_owner, null: false, default: false
      t.boolean :visible, null: false, default: false
      t.boolean :can_edit, null: false, default: false

      t.timestamps
    end
  end
end
