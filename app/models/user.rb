class User < ApplicationRecord
   has_secure_password
   validates_presence_of :name, :email
   validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
   validates :password_digest, presence: true
   has_many :user_parties
   has_many :viewing_parties, through: :user_parties
end
