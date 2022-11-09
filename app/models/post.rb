class Post < ApplicationRecord
  # Currently missing attachment attribute

  # Associations
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  # Validations
  validates :title, :body, :status, :user_id, presence: true

  ## temp validation
  validates :title, uniqueness: true

  # Enums
  enum status: {
    archieved: 0,
    published: 10
  }, _prefix: :status

  # Scopes
  scope :published_by, ->(id) {
    where("user_id = ?", id)
   }

end
