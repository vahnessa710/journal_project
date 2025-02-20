class User < ApplicationRecord
  has_secure_password
  has_many :categories, dependent: :destroy
  has_many :tasks, through: :categories, dependent: :destroy

  validates :email, presence: { message: "Email can't be blank." }, uniqueness: { message: "Email is already taken." }
  validates :password, length: { minimum: 6, message: "Password must be at least 6 characters long." }
  validates :password_confirmation, presence: { message: "Please confirm your password." }

end
