class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|

      t.references :user, null: false
      t.references :post, null: false
      t.string :body, null: false
      t.timestamps
    end
  end
end
