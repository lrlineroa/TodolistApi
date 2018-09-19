class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :state, null: false

      t.timestamps
    end
    add_index :states, :state, unique: true
  end
end
