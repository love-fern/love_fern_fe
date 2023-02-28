class User
  def initialize(data)
    @uid = data[:uid]
    @name = data[:info][:name]
    @email = data[:info][:email]
    @image = data[:info][:image]
  end

  def raw_data
    {
      uid: @uid,
      name: @name,
      email: @email,
      image: @image
    }
  end
end
