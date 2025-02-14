class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  default_scope { order(created_at: :desc) }
  validates :name, presence: { message: "Please enter a title." }
  
end
