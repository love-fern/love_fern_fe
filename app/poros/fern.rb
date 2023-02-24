class Fern
  attr_reader :id, :name, :shelf, :preferred_contact_method, :health, :image
  def initialize(fern_info)
    @id = fern_info[:id]
    @name = fern_info[:name]
    @shelf = fern_info[:shelf]
    @preferred_contact_method = fern_info[:preferred_contact_method]
    @health = fern_info[:health]
    @image = set_image(fern_info[:health])
  end

  def set_image(health)
    image_number = (health+1)/2
    "love-fern-#{image_number}_720.png"
  end
end