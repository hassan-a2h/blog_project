class DropBodyFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :body, :string
  end
end
