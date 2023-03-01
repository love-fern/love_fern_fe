require 'rails_helper'

RSpec.describe FernService do
  let(:user) do
    {
      'uid' => '110920554030325122207',
      'name' => 'Samuel Cox',
      'email' => 'samc1253@gmail.com',
      'image' => 'https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c'
    }
  end

  describe '.create_fern' do
    it 'creates a new fern for a user', :vcr do
      WebMock.disable!
      fern_params = {
        name: 'The Big Pepperoni',
        preferred_contact_method: 'text',
        shelf: 'Family'
      }
      
      response = FernService.create_fern(user['uid'], fern_params)
      expected = File.read('spec/fixtures/fern_service/create_fern.json')

      expect(response.status).to eq(201)
      expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
    end
  end

  describe '.get_all_ferns' do
    it 'gets all ferns for a user', :vcr do
      WebMock.disable!
      response = FernService.get_all_ferns(user['uid'])
      expected = File.read('spec/fixtures/fern_service/get_all_ferns.json')

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
    end
  end
end
