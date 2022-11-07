class User < ApplicationRecord
  # Devise's Features
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # Associations
  has_many :posts
  has_many :comments

  # Validations
  validates :user_name, :role, presence: true
  validates :email, uniqueness: true

  # Enums
  enum role: {
    user: 0,
    mod: 1,
    admin: 2
  }, _prefix: :role

end
