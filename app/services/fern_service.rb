class FernService
  def self.conn
    Faraday.new(url: "http://localhost:3000")
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  # ferns
  def self.create_fern(google_id, fern_params)
    conn.post("/api/v1/users/#{google_id}/ferns", fern_params)
  end

  def self.get_all_ferns(google_id)
    conn.get("/api/v1/users/#{google_id}/ferns")
  end

  def self.get_fern(google_id, fern_id)
    conn.get("/api/v1/users/#{google_id}/ferns/#{fern_id}")
  end

  def self.update_fern(google_id, fern_id, fern_params)
    conn.patch("/api/v1/users/#{google_id}/ferns/#{fern_id}", fern_params)
  end

  def self.delete_fern(google_id, fern_id)
    conn.delete("/api/v1/users/#{google_id}/ferns/#{fern_id}")
  end 

  # shelves
  def self.get_ferns_on_shelf(google_id, shelf_id)
    conn.get("/api/v1/users/#{google_id}/shelves/#{shelf_id}/ferns")
  end

  def self.add_fern_to_shelf(google_id, shelf_id, fern_id)
    conn.post("/api/v1/users/#{google_id}/shelves/#{shelf_id}/ferns/#{fern_id}")
  end

  def self.remove_fern_from_shelf(google_id, shelf_id, fern_id)
    conn.delete("/api/v1/users/#{google_id}/shelves/#{shelf_id}/ferns/#{fern_id}")
  end
end
