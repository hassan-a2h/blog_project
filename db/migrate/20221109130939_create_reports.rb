# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.belongs_to :reportable, polymorphic: true, null: false
      t.belongs_to :user, null: false
      t.string :message, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
