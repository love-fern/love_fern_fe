class FernFacade
  def self.find_fern(user_id, fern_id)
    unparsed = FernService.get_fern(user_id, fern_id)
    parsed = FernService.parse_json(unparsed)
    Fern.new(parsed[:data], parsed[:included])
  end

  def self.delete_fern(user_id, fern_id)
    FernService.delete_fern(user_id, fern_id)
  end
end
