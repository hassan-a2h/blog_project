# frozen_string_literal: true

class Post < ApplicationRecord
  has_rich_text :content
  has_one_attached :attachment
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  validates :title, :status, :user_id, presence: true
  validate :picture_only

  enum status: {
    pending: 0,
    published: 10,
    unpublished: 15,
    rejected: 20
  }

  default_scope { order(created_at: :desc) }
  scope :published_posts, -> { where('status = 10') }
  scope :published_by, ->(id) { where('user_id = ?', id) }
  scope :pending_posts, -> { where('status = 0') }

  private

  def picture_only
    return if attachment.present?

    extension = attachment.filename.to_s.split('.').last
    return if %w[svg eps tiff gif jpg jpeg png].include?(extension.downcase)

    errors.add(:attachment, 'Invalid Format')
    return unless attachment.byte_size > 4_000_000

    errors.add(:attachment, 'Error! file size too big')
  end
end
