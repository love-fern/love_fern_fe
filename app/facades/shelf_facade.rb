class ShelfFacade
  def self.user_shelves(google_id)
    full = FernService.parse_json(FernService.find_shelves(google_id))
    ferns = full[:included]
    shelves = full[:data]

    shelves.map do |shelf|
      Shelf.new(shelf, ferns)
    end
  end
end