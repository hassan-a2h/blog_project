class Report < ApplicationRecord

  # Associations
  belongs_to :reportable, polymorphic: true
  belongs_to :user

  # Enums
  enum status: {
    pending: 0,
    resolved: 1
  }, _prefix: true
end
