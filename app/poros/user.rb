class User
  def initialize(data)
    @uid = data[:uid]
    @name = data[:info][:name]
    @email = data[:info][:email]
    @image = data[:info][:image]
  end
end