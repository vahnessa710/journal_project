class Category < ApplicationRecord
  has_many :tasks, dependent: :destroy
  default_scope { order(created_at: :desc) }
end
