class User < ApplicationRecord
 
  # Devise ke modules already honge
  has_many :user_books
  has_many :books, through: :user_books

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
end
