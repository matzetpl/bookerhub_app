class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :image
      t.text :description
      t.integer :organization_id
      t.integer :category_id
      t.string :status, default: 0, null: false  # Set default value for status
      t.timestamps
    end
  end
end
