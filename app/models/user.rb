class User < ApplicationRecord
  has_secure_password
  has_many :categories, dependent: :destroy
  has_many :tasks, through: :categories, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
end
