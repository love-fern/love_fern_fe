require 'rails_helper'

RSpec.describe 'stats view', :vcr do
  let(:user) do
    {
      'uid' => '110920554030325122207',
      'name' => 'Samuel Cox',
      'email' => 'samc1253@gmail.com',
      'image' => 'https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c'
    }
  end

  before {
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit fern_stats_path(9)
  }

  it 'has a title', :vcr do
    expect(page).to have_content("Brady's Stats")
  end

  it 'shows a graph of fern health over time' do
    expect(page).to have_content('Fern Health')
    
    images = page.all('img')
  
    expect(images[2][:src]).to eq("/assets/ferns-axis-578f5de35ceab7f468f5bbbac87d081ea1decade37a0e4ce77d20611e55b172f.png")
  end

  it 'shows a graph of interactions over time' do
    expect(page).to have_content('Interactions')

    images = page.all('img')
  
    expect(images[3][:src]).to eq("/assets/emojis/axis-b680203a38ded61f1ac0f7f019daff6be0accd67140e2bba509df17caa649f1c.png")
  end
end