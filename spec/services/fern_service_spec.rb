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
      response = FernService.get_all_ferns(user['uid'])
      expected = File.read('spec/fixtures/fern_service/get_all_ferns.json')

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
    end
  end

  describe '.get_fern' do
    it 'gets a fern for a user', :vcr do
      response = FernService.get_fern(user['uid'], 2)
      expected = File.read('spec/fixtures/fern_service/get_fern.json')

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(JSON.parse(expected))    
    end
  end

  describe '.update_fern' do
    it 'updates a fern', :vcr do
      fern_update_params = {
        shelf: 'Business',
        name: 'Fernilicious',
        preferred_contact_method: "Don't" 
      }

      response = FernService.update_fern(user['uid'], 3, fern_update_params)
      expected = File.read('spec/fixtures/fern_service/update_fern.json')

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
    end
  end

  describe '.delete_fern' do
    it 'deletes a fern', :vcr do
      response = FernService.delete_fern(user['uid'], 4)
      expected = File.read('spec/fixtures/fern_service/delete_fern.json')

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
    end
  end
end
