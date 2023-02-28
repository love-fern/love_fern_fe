class Interaction
  attr_reader :positivity, :created_at

  def initialize(interaction_data)
    @id = interaction_data[:id]
    @positivity = interaction_data[:attributes][:evaluation].downcase
    @created_at = Date.parse(interaction_data[:attributes][:created_at]).strftime('%d %B %Y')
  end

end