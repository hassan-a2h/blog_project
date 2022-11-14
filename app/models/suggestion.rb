class Suggestion < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post
  has_many :replies, as: :replyable, dependent: :destroy

  # Validations
  validates :user_id, :post_id, :body, :status, presence: true

  ## temp validation
  validates :body, uniqueness: true

  # Enums
  enum status: {
    accepted: 0,
    proposed: 10,
    edited: 20,
    rejected: 30
  }

  # Scopes
  scope :by_post, ->(id) { where("post_id = ?", id).order(created_at: :desc) }
  scope :by_user, ->(id) { where("user_id = ?", id).order(created_at: :desc) }
end
