class Fern
  def initialize(fern_info)
    @name = fern_info[:name]
    @shelf = fern_info[:shelf]
    @preferred_contact_method = fern_info[:preferred_contact_method]
    @health = fern_info[:health]
  end
end