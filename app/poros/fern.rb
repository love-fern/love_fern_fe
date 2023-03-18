class Fern
  attr_reader :id, :name, :shelf, :preferred_contact_method, :health, :image, :user_id, :interactions

  def initialize(fern_info, included = false)
    @id = fern_info[:id]
    @name = fern_info[:attributes][:name]
    @shelf = fern_info[:relationships][:shelf][:data][:id]
    @preferred_contact_method = fern_info[:attributes][:preferred_contact_method]
    @health = fern_info[:attributes][:health].to_f
    @image = set_image(@health)
    @user_id = find_user_id(included) if included
    @interactions = create_interactions(included) if included
  end

  private

  def set_image(health)
    if health == 0
      image_number = 1
    else
      image_number = (health/2).ceil
    end
    "love-fern-#{image_number}_720.png"
  end

  def find_user_id(included)
    user_hash = included.select { |x| x[:type] == 'user' }
    user_hash.first[:attributes][:google_id]
  end

  def find_interactions(included)
    included.select { |x| x[:type] == 'interaction' }
  end

  def create_interactions(included)
    find_interactions(included).map do |interaction_data|
      Interaction.new(interaction_data)
    end
  end
end
