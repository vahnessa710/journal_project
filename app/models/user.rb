class User < ApplicationRecord
  has_many :categories, through: :tasks
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true
end
