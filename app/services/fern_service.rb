class FernService
  def self.conn
    Faraday.new(url: "http://localhost:5000")
  end

  def self.find_shelves(google_id)
    conn.get("/api/v1/users/#{google_id}/shelves")
  end

  def self.create_fern(google_id, fern_params)
    conn.post("/api/v1/users/#{google_id}/ferns", fern_params)
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end