class CreateHeroes < ActiveRecord::Migration[5.0]
  def change
    create_table :heroes do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :heroes, :name, unique: true
  end
end
