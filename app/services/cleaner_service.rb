class CleanerService
  def self.conn
    Faraday.new(
      url: "#{ENV['URL']}/api/v1/",
      headers: { FErn_key: ENV['FErn_key'] }
    )
  end

  def self.reset_seeds
    conn.get('/reset_seeds')
  end
end