class FernService
  def self.conn
    Faraday.new(
      url: "#{ENV['HOST_URL']}/api/v1/",
      headers: { FERN_KEY: ENV['FERN_KEY'] }
    )
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  # users
  def self.create_user(user_info)
    conn.post('users', user_info)
  end

  # ferns
  def self.create_fern(google_id, fern_params)
    conn.post("users/#{google_id}/ferns", fern_params)
  end

  def self.get_all_ferns(google_id)
    conn.get("users/#{google_id}/ferns")
  end

  def self.get_fern(google_id, fern_id)
    conn.get("users/#{google_id}/ferns/#{fern_id}")
  end

  def self.update_fern(google_id, fern_id, fern_params)
    conn.patch("users/#{google_id}/ferns/#{fern_id}", fern_params)
  end

  def self.delete_fern(google_id, fern_id)
    conn.delete("users/#{google_id}/ferns/#{fern_id}")
  end

  def self.get_fern_stats(google_id, fern_id)
    conn.get("users/#{google_id}/ferns/#{fern_id}/stats")
  end

  # shelves
  def self.get_all_shelves(google_id)
    conn.get("users/#{google_id}/shelves")
  end

  # external APIs
  def self.get_an_activity
    conn.get('activities')
  end
end
