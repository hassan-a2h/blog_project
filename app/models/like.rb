class Like < ApplicationRecord

  # Associations
  belongs_to :likeable, polymorphic: true

  # Validations
  validates :user_id, :likeable_type, :likeable_id, presence: true
  # Enums

  # Scopes
  scope :already_made, ->(post_id, user_id) { find_by(likeable_id: post_id, user_id: user_id) }
end
