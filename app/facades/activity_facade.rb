class ActivityFacade
  def self.get_an_activity
    json = JSON.parse(FernService.get_an_activity.body, symbolize_names: true)
    Activity.new(json)
  end
end