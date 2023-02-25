require 'rails_helper'

RSpec.describe "Add Interaction To Fern", type: :feature do
  describe 'Edit Fern', :vcr do
    let(:user) { {
      'uid' => "110920554030325122207",
      'name' => "Samuel Cox",
      'email' => "samc1253@gmail.com",
      'image' => "https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c"
    } }

    it 'has the name of the fern at the top of the page' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit water_fern_path(1)

      expect(page).to have_content("Erin's Fern")
      expect(page).to have_field('Interaction')
    end
  end
end