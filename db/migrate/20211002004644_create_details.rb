class CreateDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :details do |t|
      t.integer :list_id
      t.string :attribute_type
      t.string :value
      t.string :coordinate

      t.timestamps
    end
  end
end
