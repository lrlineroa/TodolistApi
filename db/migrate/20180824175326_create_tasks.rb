class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name ,null: false
      t.references :list,foreign_key: true, null: false

      t.timestamps
    end
  end
end
