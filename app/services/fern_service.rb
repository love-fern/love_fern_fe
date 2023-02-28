class FernService
  def self.conn
    Faraday.new(
      url: "#{ENV['HOST_URL']}/api/v1/",
      headers: { FErn_key: ENV['FERN_KEY'] }
    )
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  # users
  def self.create_user(user_info)
    conn.post("users", user_info)
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

  # shelves
  def self.get_all_shelves(google_id)
    conn.get("users/#{google_id}/shelves")
  end
  
  def self.get_ferns_on_shelf(google_id, shelf_id)
    conn.get("users/#{google_id}/shelves/#{shelf_id}/ferns")
  end

  def self.add_fern_to_shelf(google_id, shelf_id, fern_id)
    conn.post("users/#{google_id}/shelves/#{shelf_id}/ferns/#{fern_id}")
  end

  def self.remove_fern_from_shelf(google_id, shelf_id, fern_id)
    conn.delete("users/#{google_id}/shelves/#{shelf_id}/ferns/#{fern_id}")
  end

  # external APIs
  def self.get_an_activity
    conn.get('activities')
  end
end
