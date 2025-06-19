class CreateToDos < ActiveRecord::Migration[8.0]
  def change
    create_table :to_dos do |t|
      t.string :title
      t.boolean :completed

      t.timestamps
    end
  end
end
