class ShelfFacade
  def self.user_shelves(google_id)
    shelves = FernService.parse_json(FernService.find_shelves(google_id))[:data]

    shelves.map do |shelf|
      Shelf.new(shelf)
    end
  end
end