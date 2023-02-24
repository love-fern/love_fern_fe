class Fern
  attr_reader :id, :name, :shelf, :preferred_contact_method, :health
  def initialize(fern_info)
    @id = fern_info[:id]
    @name = fern_info[:name]
    @shelf = fern_info[:shelf]
    @preferred_contact_method = fern_info[:preferred_contact_method]
    @health = fern_info[:health]
  end
end