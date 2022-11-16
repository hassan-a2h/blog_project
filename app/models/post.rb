# frozen_string_literal: true

class Post < ApplicationRecord
  has_one_attached :attachment
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  validates :title, :body, :status, :user_id, presence: true

  enum status: {
    archieved: 0,
    published: 10
  }

  scope :published_by, ->(id) { where("user_id = ?", id) }
end
