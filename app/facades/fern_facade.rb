class FernFacade
  def self.create_fern(fern_info)
  end

  def self.find_fern(user_id, fern_id)
    unparsed = FernService.get_fern(user_id, fern_id)
    Fern.new(FernService.parse_json(unparsed)[:data])
  end
end