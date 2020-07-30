require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #homes" do
    it "returns http success" do
      get :homes
      expect(response).to have_http_status(:success)
    end
  end

end
