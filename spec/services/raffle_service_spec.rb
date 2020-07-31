require 'rails_helper'

describle RaffleService do
  before :each do
    @campaign = create(:campaign, status: :pending)
  end

  describle '#call' do
    context "when has more then two members" do
      before(:each) do
        create(:member, campaign: @campaign)
        create(:member, campaign: @campaign)
        create(:member, campaign: @campaign)

        @results = RaffleService.new(@campaign).call
      end

      it "results is a hash" do
        expect(@results.class).to eq(Hash)
      end

      it "all members are in results as a member" do
        result_members = @results.map {|r| r.first}
        expect(result_members.sort).to eq(@campaign.members.sort)
      end

      it "all member are in results as a friend" do
        result_friends = @results.map {|r| r.last}
        expect(result_friends.sort).to eq(@campaign.member.sort)
      end

      xit "a member don't get a member y that get the member x" do
        # Desafio
      end
    end

    context "when don't has more then two members" do
      before(:each) do
        create(:member, campaign: @campaign)
        @campaign.reload
        
        @response = RaffleService.new(@campaign).call
      end

      it "retorns false" do
        expect(@response).to eql(false)
      end
    end
  end
end