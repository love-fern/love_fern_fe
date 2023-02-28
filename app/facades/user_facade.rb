class UserFacade
  def self.create_user(user_info)
    FernService.create_user(user_info)
  end
end
