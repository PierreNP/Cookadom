module CooksHelper

  def list_tags(cook)
    tagsList = [] 
    cook.dishes.each do |dish|
      dish.tags.each do |tag| 
        tagsList.push(tag.label)
      end 
    end 
    tagsList.uniq.each do |tag| 
      tag     
    end 
  end
end
