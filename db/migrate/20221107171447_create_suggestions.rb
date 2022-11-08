class CreateSuggestions < ActiveRecord::Migration[5.2]
  def change
    create_table :suggestions do |t|
      t.references :post, null: false
      t.references :user, null: false
      t.string :body, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
