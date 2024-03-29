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

      expect(response.status).to eq(201)

      fern_response = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(fern_response[:id]).to be_a(String)
      expect(fern_response[:id].to_i).to_not eq(0)

      expect(fern_response[:type]).to eq('fern')

      expect(fern_response[:attributes][:name]).to eq(fern_params[:name])
      expect(fern_response[:attributes][:health]).to eq(7)
      expect(fern_response[:attributes][:preferred_contact_method]).to eq(fern_params[:preferred_contact_method])

      expect(fern_response[:relationships][:shelf][:data][:id]).to be_a(String)
      expect(fern_response[:relationships][:shelf][:data][:id].to_i).to_not eq(0)
      expect(fern_response[:relationships][:shelf][:data][:type]).to eq('shelf')

      expect(fern_response[:relationships][:user][:data][:id]).to be_a(String)
      expect(fern_response[:relationships][:user][:data][:id].to_i).to_not eq(0)
      expect(fern_response[:relationships][:user][:data][:type]).to eq('user')

      expect(fern_response[:relationships][:interactions][:data]).to be_an(Array)
    end
  end

  describe '.get_all_ferns' do
    it 'gets all ferns for a user', :vcr do
      response = FernService.get_all_ferns(user['uid'])

      expect(response.status).to eq(200)

      ferns_response = JSON.parse(response.body, symbolize_names: true)[:data]

      ferns_response.each do |fern|
        expect(fern[:id]).to be_a(String)
        expect(fern[:id].to_i).to_not eq(0)
        expect(fern[:type]).to eq('fern')

        expect(fern[:attributes][:name]).to be_a(String)
        expect(fern[:attributes][:health]).to be_a(Float)
        expect(fern[:attributes][:preferred_contact_method]).to be_a(String)
  
        expect(fern[:relationships][:shelf][:data][:id]).to be_a(String)
        expect(fern[:relationships][:shelf][:data][:id].to_i).to_not eq(0)
        expect(fern[:relationships][:shelf][:data][:type]).to eq('shelf')

        expect(fern[:relationships][:user][:data][:id]).to be_a(String)
        expect(fern[:relationships][:user][:data][:id].to_i).to_not eq(0)
        expect(fern[:relationships][:user][:data][:type]).to eq('user')

        expect(fern[:relationships][:interactions][:data]).to be_an(Array)
      end
    end
  end

  describe '.get_fern' do
    it 'gets a fern for a user', :vcr do
      response = FernService.get_fern(user['uid'], 9)

      expect(response.status).to eq(200)

      fern_response = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(fern_response[:id]).to be_a(String)
      expect(fern_response[:id].to_i).to_not eq(0)

      expect(fern_response[:type]).to eq('fern')

      expect(fern_response[:attributes][:name]).to be_a(String)
      expect(fern_response[:attributes][:health]).to be_a(Float)
      expect(fern_response[:attributes][:preferred_contact_method]).to be_a(String)

      expect(fern_response[:relationships][:shelf][:data][:id]).to be_a(String)
      expect(fern_response[:relationships][:shelf][:data][:id].to_i).to_not eq(0)
      expect(fern_response[:relationships][:shelf][:data][:type]).to eq('shelf')

      expect(fern_response[:relationships][:user][:data][:id]).to be_a(String)
      expect(fern_response[:relationships][:user][:data][:id].to_i).to_not eq(0)
      expect(fern_response[:relationships][:user][:data][:type]).to eq('user')

      expect(fern_response[:relationships][:interactions][:data][0][:id]).to be_a(String)
      expect(fern_response[:relationships][:interactions][:data][0][:id].to_i).to_not eq(0)
      expect(fern_response[:relationships][:interactions][:data][0][:type]).to eq('interaction')

      included_response = JSON.parse(response.body, symbolize_names: true)[:included]

      included_response.each.with_index do |included, i|
        expect(included[:id]).to be_a(String)
        expect(included[:id].to_i).to_not eq(i)
        expect(included[:type]).to eq('interaction')
  
        expect(included[:attributes][:evaluation]).to be_a(Float)
        expect(included[:attributes][:created_at]).to be_a(String)
  
        expect(included[:relationships][:fern][:data][:id]).to be_a(String)
        expect(included[:relationships][:fern][:data][:id].to_i).to_not eq(0)
        expect(included[:relationships][:fern][:data][:type]).to eq('fern')

        break if i==2
      end

      expect(included_response[3][:id]).to be_a(String)
      expect(included_response[3][:id].to_i).to_not eq(0)
      expect(included_response[3][:type]).to eq('user')

      expect(included_response[3][:attributes][:name]).to be_a(String)
      expect(included_response[3][:attributes][:email]).to be_a(String)
      expect(included_response[3][:attributes][:google_id]).to be_a(String)
      expect(included_response[3][:attributes][:google_id].to_i).to_not eq(0)
    end
  end

  describe '.update_fern' do
    it 'updates a fern', :vcr do
      fern_update_params = {
        shelf: 'Business',
        name: 'Fernilicious',
        preferred_contact_method: "Don't" 
      }

      response = FernService.update_fern(user['uid'], 2, fern_update_params)

      expect(response.status).to eq(200)

      fern_response = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(fern_response[:id]).to be_a(String)
      expect(fern_response[:id].to_i).to_not eq(0)

      expect(fern_response[:type]).to eq('fern')

      expect(fern_response[:attributes][:name]).to eq(fern_update_params[:name])
      expect(fern_response[:attributes][:health]).to be_a(Float)
      expect(fern_response[:attributes][:preferred_contact_method]).to eq(fern_update_params[:preferred_contact_method])

      expect(fern_response[:relationships][:shelf][:data][:id]).to eq("4")
      expect(fern_response[:relationships][:shelf][:data][:type]).to eq('shelf')

      expect(fern_response[:relationships][:user][:data][:id]).to be_a(String)
      expect(fern_response[:relationships][:user][:data][:id].to_i).to_not eq(0)
      expect(fern_response[:relationships][:user][:data][:type]).to eq('user')

      expect(fern_response[:relationships][:interactions][:data]).to be_an(Array)
    end
  end

  describe '.delete_fern' do
    it 'deletes a fern', :vcr do
      response = FernService.delete_fern(user['uid'], 3)

      expect(response.status).to eq(200)

      fern_response = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(fern_response[:id]).to eq("3")
      expect(fern_response[:type]).to eq('fern')

      expect(fern_response[:attributes][:name]).to be_a(String)
      expect(fern_response[:attributes][:health]).to be_a(Float)
      expect(fern_response[:attributes][:preferred_contact_method]).to be_a(String)

      expect(fern_response[:relationships][:shelf][:data][:id]).to be_a(String)
      expect(fern_response[:relationships][:shelf][:data][:id].to_i).to_not eq(0)
      expect(fern_response[:relationships][:shelf][:data][:type]).to eq('shelf')

      expect(fern_response[:relationships][:user][:data][:id]).to be_a(String)
      expect(fern_response[:relationships][:user][:data][:id].to_i).to_not eq(0)
      expect(fern_response[:relationships][:user][:data][:type]).to eq('user')

      expect(fern_response[:relationships][:interactions][:data]).to be_an(Array)
    end
  end

  describe '.get_fern_stats', :vcr do
    it 'gets fern health history' do
      FernService.update_fern(user['uid'], 5, interaction: 'I love you')
      FernService.update_fern(user['uid'], 5, interaction: 'I hate you')
      FernService.update_fern(user['uid'], 5, interaction: 'I sort of like you')
      FernService.update_fern(user['uid'], 5, interaction: "I don't care")
      response = FernService.get_fern_stats(user['uid'], 5)
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:id]).to be_a(String)
      expect(parsed_response[:data][:type]).to eq('fern')

      expect(parsed_response[:data][:attributes][:name]).to be_a(String)
      expect(parsed_response[:included]).to be_an(Array)

      interactions = parsed_response[:included].select { |x| x[:type] == 'interaction' }

      interactions.each do |interaction|
        expect(interaction[:id]).to be_a(String)
        expect(interaction[:type]).to eq('interaction')
        expect(interaction[:attributes][:evaluation]).to be_a(Float)
        expect(interaction[:attributes][:description]).to be_a(String)
      end
    end
  end
end
