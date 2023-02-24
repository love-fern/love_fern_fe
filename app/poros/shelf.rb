class Shelf
  attr_reader :id, :name, :ferns
  def initialize(data, included)
    @id = data[:id]
    @name = data[:attributes][:name]
    @ferns = parse_ferns(included)
  end

  def parse_ferns(ferns)
    ferns.filter_map do |fern|
      if fern[:relationships][:shelf][:data][:id] == @id
        fern[:attributes][:shelf] = fern[:relationships][:shelf][:data][:id]
        fern[:attributes][:id] = fern[:id]
        Fern.new(fern[:attributes])
      end
    end
  end
end