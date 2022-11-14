class Reply < ApplicationRecord
  # Associations
  belongs_to :replyable, polymorphic: true
  belongs_to :user

  # Validations
  validates :body, :replyable_type, :replyable_id, :user_id, presence: true
end
