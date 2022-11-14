class Reply < ApplicationRecord
  # Associations
  belongs_to :replyable, polymorphic: true

  # Validations
  validates :user_id, :likeable_type, :likeable_id, presence: true
end
