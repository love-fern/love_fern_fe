class Fern
  attr_reader :id, :name, :shelf, :preferred_contact_method, :health, :image, :user_id
  def initialize(fern_info, included = false)
    @id = fern_info[:id]
    @name = fern_info[:attributes][:name]
    @shelf = fern_info[:relationships][:shelf][:data][:id]
    @preferred_contact_method = fern_info[:attributes][:preferred_contact_method]
    @health = fern_info[:attributes][:health]
    @image = set_image(fern_info[:attributes][:health])
    @user_id = included.first[:attributes][:google_id] if included
  end

  def set_image(health)
    image_number = (health+1)/2
    "love-fern-#{image_number}_720.png"
  end
end