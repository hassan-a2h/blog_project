class Comment < ApplicationRecord

  # Associations
  belongs_to :user
  belongs_to :post

  # Validations
  validates :body, :user_id, :post_id, presence: true

  ## temp validation
  validates :body, uniqueness: true

  # Enums


  # Scopes
  scope :by_post, -> (id) { where("post_id = ?", id).order(created_at: :desc) }
  scope :by_user, -> (id) { where("user_id = ?", id).order(created_at: :desc) }

end
