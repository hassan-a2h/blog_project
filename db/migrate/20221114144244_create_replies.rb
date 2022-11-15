# frozen_string_literal: true

class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.belongs_to :replyable, polymorphic: true
      t.string :body, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
