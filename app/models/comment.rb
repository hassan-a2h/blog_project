class Comment < ApplicationRecord

  # Associations
  belongs_to :user
  belongs_to :post

  # Validations
  validates :body, :user_id, :post_id, presence: true

  # Enums
end
