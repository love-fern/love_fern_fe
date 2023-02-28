class Shelf
  attr_reader :id, :name, :ferns

  def initialize(data, included)
    @id = data[:id]
    @name = data[:attributes][:name]
    @ferns = parse_ferns(included)
  end

  def parse_ferns(ferns)
    ferns.filter_map do |fern|
      Fern.new(fern) if fern[:relationships][:shelf][:data][:id] == @id
    end
  end
end
