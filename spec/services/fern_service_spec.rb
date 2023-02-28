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

  # not testing shelf association. need FernService.get_shelf?
  describe '.create_fern' do
    it 'creates a new fern', :vcr do
      fern_params = {
        name: 'The Big Pepperoni',
        preferred_contact_method: 'text',
        shelf: 'Family'
      }

      create_response = FernService.create_fern(user['uid'], fern_params)

      expect(create_response.success?).to eq(true)

      new_fern_id = JSON.parse(create_response.body, symbolize_names: true)[:data][:id]
      new_fern_response = FernService.get_fern(user['uid'], new_fern_id)

      expect(new_fern_response.success?).to eq(true)

      parsed_response = JSON.parse(new_fern_response.body, symbolize_names: true)

      expect(parsed_response[:data][:type]).to eq('fern')
      expect(parsed_response[:data][:attributes][:name]).to eq(fern_params[:name])
      expect(parsed_response[:data][:attributes][:preferred_contact_method]).to eq('text')

      expect(parsed_response[:included][0][:type]).to eq('user')
      expect(parsed_response[:included][0][:attributes][:name]).to eq(user['name'])
      expect(parsed_response[:included][0][:attributes][:email]).to eq(user['email'])
      expect(parsed_response[:included][0][:attributes][:google_id]).to eq(user['uid'])
    end
  end
end
