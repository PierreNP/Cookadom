class User < ApplicationRecord
  after_create :welcome_send

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

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }
  validates :first_name, length: { in: 1..20 }
  validates :last_name, length: { in: 1..20 }
  validates :status, presence: true
  validates :phone, uniqueness: true, numericality: { only_integer: true }, length: { is: 10 }

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

end