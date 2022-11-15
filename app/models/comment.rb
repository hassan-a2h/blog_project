# frozen_string_literal: true

class Comment < ApplicationRecord
  has_one_attached :attachment
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :replies, as: :replyable, dependent: :destroy

  validates :body, :user_id, :post_id, presence: true

  scope :by_post, ->(id) { where('post_id = ?', id).order(created_at: :desc) }
  scope :by_user, ->(id) { where('user_id = ?', id).order(created_at: :desc) }
end
