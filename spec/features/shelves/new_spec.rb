require 'rails_helper'

RSpec.describe 'new shelf page', type: :feature do
  let(:user) do
    {
      'uid' => '110920554030325122207',
      'name' => 'Samuel Cox',
      'email' => 'samc1253@gmail.com',
      'image' => 'https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c'
    }
  end

  describe 'happy path', :vcr do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit new_shelf_path
    end

    describe 'page layout' do
      it "has 'Create Your New Shelf' as a title" do
        expect(page).to have_content("Create Your New Shelf")
      end

      it 'has a field input for shelf name' do
        expect(page).to have_field(:name)
      end

      it 'has a button to submit the form' do
        expect(page).to have_button("Create Shelf!")
      end
    end
    describe 'shelf creation', :vcr do
      it 'should create a shelf' do
        fill_in :name, with: "All The Baddies In My Life"
        click_button "Create Shelf!"

        expect(current_path).to eq(greenhouse_path)
      end
    end
  end
end