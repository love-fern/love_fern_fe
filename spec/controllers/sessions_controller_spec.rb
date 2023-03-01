require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'Sessions Creation', :vcr do
    let(:raw_user) { {
      :provider=>"google_oauth2",
      :uid=>"110920554030325122207",
      :info=>{
        :name=>"Samuel Cox",
        :email=>"samc1253@gmail.com",
        :unverified_email=>"samc1253@gmail.com",
        :email_verified=>true,
        :first_name=>"Samuel",
        :last_name=>"Cox",
        :image=>
          "https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c"
      }} }
    it 'creates a session when a user logs in' do
      allow_any_instance_of(SessionsController).to receive(:user_information).and_return(raw_user)

      post :create

      expect(session[:user]).to eq({:uid=>"110920554030325122207", :name=>"Samuel Cox", :email=>"samc1253@gmail.com", :image=>"https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c", :google_id=>"110920554030325122207"})
    end
  end

  describe 'Sessions Deletion' do
    it 'can delete a session' do
      session[:user] = {:uid=>"110920554030325122207", :name=>"Samuel Cox", :email=>"samc1253@gmail.com", :image=>"https://lh3.googleusercontent.com/a/AGNmyxYt32X4YBRyuQij1sMMfHp6BbnKBs2Uaic2CLnLew=s96-c", :google_id=>"110920554030325122207"}

      delete :delete

      expect(session[:user]).to eq(nil)
    end
  end
end