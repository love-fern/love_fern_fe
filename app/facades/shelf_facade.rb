class ShelfFacade
  def self.user_shelves(google_id)
    full = FernService.parse_json(FernService.get_all_shelves(google_id))
    return unless full[:data]

    ferns = full[:included]
    shelves = full[:data]

    shelves.map do |shelf|
      Shelf.new(shelf, ferns)
    end
  end
end
