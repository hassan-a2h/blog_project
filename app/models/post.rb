class Post < ApplicationRecord
  # Currently missing attachment attribute

  # Associations
  belongs_to :user


  # Validations
  validates :title, :body, :status, :user_id, presence: true


  # Enums
  enum status: {
    archieved: 0,
    published: 10
  }, _prefix: :status

  # Scopes
  scope :published_by, -> (id) {
    where("user_id = ?", id)
   }

end
