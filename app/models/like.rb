# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true

  validates :user_id, presence: true

  scope :already_made, ->(post_id, user_id) { find_by(likeable_id: post_id, user_id: user_id) }
end
