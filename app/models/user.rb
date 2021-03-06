class User < ApplicationRecord
  after_create :welcome_send
  after_create :new_user_cart


  enum status: [ :user, :cook, :admin ]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  acts_as_messageable

  belongs_to :city, optional: true

  has_many :addresses
  has_one :cook
  has_many :comments
  has_many :dishes, through: :comments
  has_many :ratings
  has_many :dishes, through: :ratings
  has_many :carts
  has_many :favorit_dishes, foreign_key: 'favorit_user_id', class_name: "Favorit"


  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }
  validates :status, presence: true

  def name
    if self.first_name && self.last_name 
     name = first_name + " " + last_name
    else
      name = "Anonyme #{self.id}"
    end
  end

  def status_cook?
    status == "cook"
  end
  def status_user?
    status == "user"
  end

  def status_admin?
    status == "admin"
  end

  def past_dishes
    dishes = Array.new
    self.carts.each do |cart|
      cart.order_dishes.each do  |order|
        dishes << order.dish unless dishes.include?(order.dish) || cart.pre_validation?
      end
    end
    dishes
  end
        
  def mailboxer_email(object)
    nil
  end

  private
    def welcome_send
      UserMailer.welcome_email(self).deliver_now
    end

    def new_user_cart
      @cart = Cart.create(user_id: self.id, status: 0)
    end
end
