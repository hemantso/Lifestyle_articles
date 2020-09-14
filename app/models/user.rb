# frozen_string_literal: true

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :article, foreign_key: 'user_id', dependent: :destroy
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, presence: true, length: { maximum: 105 },

                    uniqueness: { case_sensitive: false },

                    format: { with: VALID_EMAIL_REGEX }
  
                    has_secure_password

                    has_many :votes, dependent: :destroy
                    has_many :articles, through: :votes
end
