class Shelf
  attr_reader :name, :ferns
  def initialize(data)
    @name = data[:attributes][:name]
    @ferns = parse_ferns(data[:attributes][:ferns])
  end

  def parse_ferns(ferns)
    ferns.map do |fern|
      fern[:shelf] = fern[:shelf_id]
      Fern.new(fern)
    end
  end
end