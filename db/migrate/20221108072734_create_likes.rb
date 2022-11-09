class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true, null: false
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
