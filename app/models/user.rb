class User < ApplicationRecord
  has_many :categories, through: :tasks
  has_secure_password
end
