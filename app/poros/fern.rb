class Fern(fern_info)
  def initialize
    @name = fern_info[:name]
    @shelf = fern_info[:shelf]
    @preferred_contact_method = fern_info[:preferred_contact_method]
  end
end