class Interaction
  attr_reader :evaluation, :description, :created_at

  def initialize(interaction_data)
    @id = interaction_data[:id]
    @evaluation = interaction_data[:attributes][:evaluation]
    @description = interaction_data[:attributes][:description]
    @created_at = Date.parse(interaction_data[:attributes][:created_at])
  end

  
  def emoji
    return "emojis/activity.png" if @evaluation > 1
    "emojis/#{message_level}.png"
  end
  
  def water_message
    case message_level
    when 7
      "Wow! Your fern is speechless! That's just about the nicest thing anyone's ever said to it."
    when 6
      "Your fern is beaming! That was awfully kind of you to say."
    when 5
      "Your fern liked that. It's feeling a bit better now."
    when 4
      "Hmm... Your fern doesn't know what to think about that."
    when 3
      "Oof. Your fern didn't much care for that."
    when 2
      "Yikes! Your fern just died a little inside."
    when 1
      "The cruelty of man knows no bounds. Your fern is deeply hurt by these words."
    end
  end
  
  def display_message
    if @description == 'message'
      "You exchanged #{positivity} words #{days_ago}."
    else
      "You decided to #{@description[0].downcase + @description[1..-1]} #{days_ago}."
    end
  end
  
  private
  
  def message_level
    case @evaluation
    when -0.25..0.25 then 4
    when 0.25..0.50 then 5
    when 0.50..0.75 then 6
    when 0.75..1 then 7
    when -0.50..-0.25 then 3
    when -0.75..-0.50 then 2
    when -1..-0.75 then 1
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

  def positivity
    case message_level
    when 5..7
      "positive"
    when 1..3
      "negative"
    else
      "neutral"
    end
  end
end
