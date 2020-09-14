class Article < ApplicationRecord
  has_one_attached:image
  belongs_to :user
  has_many :vote, foreign_key: 'article_id', dependent: :destroy
  validates :title, presence: true, length: {minimum: 3, maximum: 50}

  validates :text, presence: true, length: {minimum: 10, maximum: 300}
  validates :image, presence: true
  validates :user_id, presence: true
  has_many :article_categories
  has_many :categories, through: :article_categories
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes
end