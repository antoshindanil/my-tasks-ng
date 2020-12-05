class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :text, null: false
      t.boolean :is_completed, default: false, null: false
      t.belongs_to :project

      t.timestamps
    end
  end
end
