class Dish < ApplicationRecord
 
   belongs_to :cook

   has_many :tag_dishes
   has_many :tags, through: :tag_dishes
   has_many :ratings
   has_many :users, through: :ratings
   has_many :order_dishes
   has_many :carts, through: :order_dishes
 
   has_one_attached :photo
   validate :avatar_format

   validates :name, presence: true, length: { in: 2..40 }
   validates :description, presence: true, length: { in: 2..400 }
   validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
   validates :ingredients, presence: true, length: { in: 5..1000 }

   def resize_image
      puts "We call me"
      puts "=" * 1000
      resized_image = MiniMagick::Image.read(self.photo.download)
      resized_image = resized_image.resize "800x800"
      v_filename = photo.filename
      v_content_type = photo.content_type
      photo.purge
      photo.attach(io: File.open(resized_image.path), filename:  v_filename, content_type: v_content_type)
  end

   private

   def photo_format
      return unless photo.attached?
      if photo.blob.content_type.start_with? 'image/'
        if photo.blob.byte_size > 10.megabytes
          errors.add(:photo, 'Taille macximum des image : 10MB')
          photo.purge
        else
          resize_image
        end
       else
         photo.purge
         errors.add(:photo, "L'photo doit être une iamge...")
       end
     end
end