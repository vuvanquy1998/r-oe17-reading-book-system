class User < ApplicationRecord
  belongs_to :role
  has_one :history
  has_many :follows
  has_many :categorys, through: :follow
  has_many :books
  has_many :likes
  has_many :books, through: :like
  has_many :comments
  has_many :books, through: :comment
end
