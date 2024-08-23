require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  let(:movie) { double("Movie", runtime: 180) }

  before do
    allow(MovieFacade).to receive(:find_movie).and_return(movie)
  end

  describe 'validations' do
    it 'validates that duration is greater than or equal to the movie runtime' do
      viewing_party = ViewingParty.new(duration: 180, movie_id: 120, date: '2024-12-31', start_time: '19:00')
      expect(viewing_party.valid?).to be true
    end

    it 'validates numericality of duration' do
      viewing_party = ViewingParty.new(duration: 'abc', movie_id: 120, date: '2024-12-31', start_time: '19:00')
      viewing_party.valid?
      expect(viewing_party.errors[:duration]).to include("must be greater than or equal to the movie runtime")
    end

    it 'validates presence of date and start_time' do
      viewing_party = ViewingParty.new(duration: 180, movie_id: 120)
      viewing_party.valid?
      expect(viewing_party.errors[:date]).to include("can't be blank")
      expect(viewing_party.errors[:start_time]).to include("can't be blank")
    end
  end

  describe '#find_host' do
    it 'returns the user who is the host of the viewing party' do
      user = create(:user)
      viewing_party = ViewingParty.create!(duration: 180, movie_id: 120, date: '2024-12-31', start_time: '19:00')
      UserParty.create!(user: user, viewing_party: viewing_party, host: true)

      expect(viewing_party.find_host).to eq(user)
    end
  end
end
