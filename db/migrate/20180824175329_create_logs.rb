class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.references :task, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.references :state, foreign_key: true, null: false
      t.text :comment

      t.timestamps
    end
  end
end
