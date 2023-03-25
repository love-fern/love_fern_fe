require 'rails_helper'

RSpec.describe FernFacade, :vcr do
  let(:user) do
    {
      'uid' => '110920554030325122207',
      'name' => 'Samuel Cox',
      'email' => 'samc1253@gmail.com',
      'image' => 'https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c'
    }
  end

  describe '.get_fern_stats' do
    it 'creates a fern poro' do
      fern = FernFacade.get_fern_stats(user['uid'], 9)

      expect(fern.class).to eq(Fern)
    end
  end
end