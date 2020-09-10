class Article < ApplicationRecord
  belongs_to :user
  has_many :vote, foreign_key: 'article_id', dependent: :destroy
  has_many :category, foreign_key: 'article_id'
  validates :title, presence: true, length: {minimum: 3, maximum: 50}

  validates :text, presence: true, length: {minimum: 10, maximum: 300}
  validates :image, presence: true
  validates :user_id, presence: true
end
