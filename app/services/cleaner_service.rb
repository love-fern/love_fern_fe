class CleanerService
  def self.conn
    Faraday.new(
      url: "http://localhost:5000/api/v1/",
      headers: { FERN_KEY: ENV['FERN_KEY'] }
    )
  end

  def self.reset_seeds
    conn.get('/reset_seeds')
  end
end