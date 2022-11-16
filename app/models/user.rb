# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy

  validates :user_name, :role, presence: true
  validates :email, uniqueness: true

  enum role: {
    user: 0,
    mod: 1,
    admin: 2
  }
end
