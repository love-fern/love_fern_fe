require 'rails_helper'

RSpec.describe FernService do
  let(:user) { {
    'uid' => "110920554030325122207",
    'name' => "Samuel Cox",
    'email' => "samc1253@gmail.com",
    'image' => "https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c"
  } }

  describe '.create_fern' do
    it 'creates a new fern', :vcr do
      fern_params = {
        name: 'The Big Pepperoni',
        preferred_contact_method: "text",
        shelf: 'Family'
      }
      
      response = FernService.create_fern(user['uid'], fern_params)
      
      expect(response.status).to eq(201)
      expect(response).to match_json_schema("fern_service/create_fern")
    end
  end
end