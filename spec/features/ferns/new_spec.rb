require 'rails_helper'

RSpec.describe 'new fern page', type: :feature do
  let(:user) { {
    'uid' => "110920554030325122207",
    'name' => "Samuel Cox",
    'email' => "samc1253@gmail.com",
    'image' => "https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c"
  } }

  describe 'page layout' do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit new_fern_path
    end

    it "has 'Plant New Fern' as a title" do
      save_and_open_page
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
end