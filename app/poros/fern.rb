class Fern
  attr_reader :id, :name, :shelf, :preferred_contact_method, :health, :image, :user_id
  def initialize(fern_info, included = false)
    @id = fern_info[:id]
    @name = fern_info[:attributes][:name]
    @shelf = fern_info[:relationships][:shelf][:data][:id]
    @preferred_contact_method = fern_info[:attributes][:preferred_contact_method]
    @health = fern_info[:attributes][:health]
    @image = set_image(fern_info[:attributes][:health])
    @user_id = find_user_id(included) if included
  end

  def set_image(health)
    image_number = (health+1)/2
    "love-fern-#{image_number}_720.png"
  end

  def find_user_id(included)
    user_hash = included.select { |x| x[:type] == 'user' }
    user_hash.first[:attributes][:google_id]
  end
end