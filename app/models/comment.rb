class Comment < ApplicationRecord

  # Associations
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  # Validations
  validates :body, :user_id, :post_id, presence: true

  ## temp validation
  validates :body, uniqueness: true

  # Enums


  # Scopes
  scope :by_post, -> (id) { where("post_id = ?", id).order(created_at: :desc) }
  scope :by_user, -> (id) { where("user_id = ?", id).order(created_at: :desc) }

end
