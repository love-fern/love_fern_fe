class Fern
  attr_reader :id, :name, :shelf, :preferred_contact_method, :health, :image, :user_id, :interactions, :stats

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
  
  def health_history # hardcoding neutral threshold and ratio from backend for now
    health = 7.0
    hash = { 0 => health }
    @interactions.reverse.each.with_index(1) do |interaction, i|
      health += interaction.evaluation*3 unless interaction.evaluation.between?(-0.25,0.25)
      health = 10 if health > 10
      health = 0 if health < 0
      hash[i] = health
    end
    hash
  end

  def interaction_history
    hash = Hash.new
    @interactions.reverse.each.with_index do |interaction, i|
      hash[i] = interaction.evaluation
    end
    hash
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
