class User < ApplicationRecord
  enum status: [ :user, :cook, :admin ]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :city
  has_many :addresses
  has_many :cooks
  has_many :comments
  has_many :sent_comments, foreign_key: 'sender_id', class_name: "Comments"
  has_many :received_comments, foreign_key: 'recipient_id', class_name: "Comments"
  has_many :ratings
  has_many :dishes, through: :ratings
  has_many :carts

end
