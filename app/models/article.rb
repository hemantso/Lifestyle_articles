class Article < ApplicationRecord
  has_one_attached :image
  
  belongs_to :user
  has_many :vote, foreign_key: 'article_id', dependent: :destroy
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }

  validates :text, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :user_id, presence: true
  validates :image, presence: true
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes
end
