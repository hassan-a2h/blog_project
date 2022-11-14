class Comment < ApplicationRecord
  # Currently missing attachment attribute

  # Associations
  has_one_attached :attachment
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :replies, as: :replyable, dependent: :destroy

  # Validations
  validates :body, :user_id, :post_id, presence: true

  ## temp validation
  validates :body, uniqueness: true

  # Enums


  # Scopes
  scope :by_post, -> (id) { where("post_id = ?", id).order(created_at: :desc) }
  scope :by_user, -> (id) { where("user_id = ?", id).order(created_at: :desc) }

end
