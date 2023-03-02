class Interaction
  attr_reader :positivity, :description, :created_at

  def initialize(interaction_data)
    @id = interaction_data[:id]
    @positivity = interaction_data[:attributes][:evaluation].downcase
    @description = interaction_data[:attributes][:description]
    @created_at = Date.parse(interaction_data[:attributes][:created_at])
  end

  def display_message
    if @description == 'message'
      "You exchanged #{@positivity} words #{days_ago}."
    else
      "You decided to #{@description[0].downcase + @description[1..-1]} #{days_ago}."
    end
  end

  def days_ago
    today = Time.now.utc.to_date
    if today == @created_at
      'today'
    elsif (today - @created_at).to_i == 1
      'yesterday'
    else
      "#{(today - @created_at).to_i} days ago"
    end
  end
end
