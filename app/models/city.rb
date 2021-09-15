class City < ApplicationRecord

  has_many :users

  validates :name, presence: true, uniqueness: true
  validates :zip_code, presence: true, uniqueness: true

  def dishes_in_a_city
    city_dishes = []
    Dish.all.each do |dish|
      if dish.status == "available" 
       cook = User.find_by(id: dish.cook.user_id)
       cook_city = City.find_by(id: cook.city_id)
        if cook_city == self
          city_dishes << dish
        end
      end
    end
    return city_dishes
  end

  
end
