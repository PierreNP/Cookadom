class Dish < ApplicationRecord
  enum status: [  :available, :unavailable, :disabled, :pinned ]
 
  belongs_to :cook

  has_many :tag_dishes
  has_many :tags, through: :tag_dishes
  has_many :ratings
  has_many :users, through: :ratings
  has_many :order_dishes
  has_many :carts, through: :order_dishes
  has_many :comments
  has_many :users, through: :comments
  has_many :favorit_users, foreign_key: 'favorit_dish_id', class_name: "Favorit"
  
  has_one_attached :photo
  
  validates_length_of :tag_dishes, maximum: 3
  validates :name, presence: true, length: { in: 2..40 }
  validates :description, presence: true, length: { in: 2..400 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :ingredients, presence: true, length: { in: 5..1000 }
  validates :status, presence: true

  def price_euro
    money = Money.from_cents(price, "EUR").format
    currency = money.slice!(0)
    money.insert(-1, " #{currency}")
  end

  def rating 
    return 0 if self.ratings.empty?
    rate_mean = 0
    self.ratings.each do |rating|
        rate_mean += rating.value
    end
    rate_mean / self.ratings.length 
  end

  def count_dish_total_number_of_votes
    return self.ratings.length
  end

  def status_fr
    case self.status
    when "disable"
        "Désactivé"
    when "unavailable"
        "Indisponible"
    when "available"
        "Disponible"
    when "pinned"
        "Épinglé"
    else
        "Statut indéfini"
    end
  end

  def self.search(search)
    if search
      dish = Dish.where("name LIKE ? OR ingredients LIKE ?","%#{search}%", "%#{search}%")
        if dish && dish != ""
          self.where(id:dish)
        else
          Dish.all
        end
    else
        Dish.all
    end
  end

  def self.all_cities
    city_dishes = []
    Dish.all.each do |dish|
      cook = User.find_by(id: dish.cook.user_id)
      cook_city = City.find_by(id: cook.city_id)
      if !city_dishes.include?(cook_city)
         city_dishes << cook_city
      end
    end
    city_dishes
  end

  def self.target(search)
    targets = Array.new
    targeted_dishes = Array.new

    self.all.each do |dish|
      if dish.status = "available" 
        
        targets << [dish.name, dish.id]
        targets << [dish.description, dish.id]
        targets << [dish.ingredients, dish.id]
        targets << [dish.cook.name, dish.id]
        dish.tags.each{ |tag| targets << [tag.label, dish.id] }
      end
    end

    targets.each do |target|
      if target[0].downcase.include?(search.downcase)
        targeted_dishes << Dish.find(target[1])
      end
    end   
    targeted_dishes
  end

end