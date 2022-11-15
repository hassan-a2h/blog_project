# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :reportable, polymorphic: true
  belongs_to :user

  enum status: {
    pending: 0,
    resolved: 1
  }

  scope :comments, -> { where('reportable_type = Comment, status = pending') }
  scope :posts, -> { where('reportable_type = Post, status = pending') }
end
