class CleanerService
  def self.conn
    Faraday.new(
      url: "#{ENV['HOST_URL']}/api/v1/",
      headers: { FErn_key: ENV['FERN_KEY'] }
    )
  end

  def self.reset_seeds
    conn.get('/reset_seeds')
  end
end
