# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :reportable, polymorphic: true
  belongs_to :user

  enum status: {
    pending: 0,
    resolved: 1
  }

  scope :comment_reports, ->(type) { where('reportable_type = ?', type).order(created_at: :desc) }
  scope :post_reports, ->(type) { where('reportable_type = ?', type).order(created_at: :desc) }
end
