require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryBot.create(:user)
    sign_in @current_user
  end

  describe "GET #create" do
    it "returns http success" do
      # setup
      member_count = Member.count
      campaign = create(:campaign, user: @current_user)

      member_params = {
        name: 'fooba',
        email: 'fooba@teste.com',
        campaign_id: campaign.id
      }

      # exercise
      post :create, params: { member: member_params }
      
      # verify
      expect(Member.count).to eq(member_count + 2)
    end

    it "redirects to the created member" do
      campaign = create(:campaign, user: @current_user)

      member_params = {
        name: 'fooba',
        email: 'fooba@teste.com',
        campaign_id: campaign.id
      }

      post :create, params: { member: member_params }
      
      expect(response).to redirect_to('/')
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      member_count = Member.count
      campaign = create(:campaign, user: @current_user)
      member = create(:member, campaign_id: campaign.id)

      delete :destroy, params: { id: member.id }

      expect(response).to have_http_status(302)
      expect(Member.count).to eq(member_count + 1)
    end
  end

  describe "GET #update" do
    xit "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

end
