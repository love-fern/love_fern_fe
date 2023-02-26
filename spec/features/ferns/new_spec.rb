require 'rails_helper'

RSpec.describe 'new fern page', type: :feature do
  let(:user) { {
    'uid' => "110920554030325122207",
    'name' => "Samuel Cox",
    'email' => "samc1253@gmail.com",
    'image' => "https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c"
  } }

  describe 'happy path' do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit new_fern_path
    end
    
    describe 'page layout' do
      it "has 'Plant New Fern' as a title" do
        expect(page).to have_content("Plant New Fern")
      end

      it 'has a field to input fern name' do
        expect(page).to have_field(:name)
      end

      it 'has a field to select shelf' do
        expect(page).to have_select(:shelf, with_options: ['Friend', 'Family', 'Romantic', 'Business'])
      end

      it 'has a field to input preferred contact method' do
        expect(page).to have_field(:preferred_contact_method)
      end

      it 'has a button to submit the form' do
        expect(page).to have_button('Plant!')
      end
    end

    describe 'fern creation', :vcr do
      it 'should create a fern' do
        fill_in :name, with: 'Drew'
        select 'Friend', from: :shelf
        fill_in :preferred_contact_method, with: 'Carrier Pigeon'
        click_button 'Plant!'

        expect(page).to have_content('Drew')

        visit fern_path(10)
        click_button('Compost Fern')
      end
    end
  end

end