# frozen_string_literal: true

class Reply < ApplicationRecord
  belongs_to :replyable, polymorphic: true
  belongs_to :user

  validates :body, :user_id, presence: true
end
