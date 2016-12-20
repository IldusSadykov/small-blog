require "rails_helper"

describe FetchCurrentLocation do
  describe ".call" do
    let!(:user) { create :user }

    subject(:interactor) do
      described_class.call(
        request_location: location,
        current_user: user
      )
    end

    context "when current_location exists" do
      let(:location) { instance_double(Location, city: "Kazan", longitude: 49.122381, latitude: 55.790745) }

      it "does return current location" do
        expect(interactor.current_location).to eq location
      end
    end

    context "when current_location does not exists" do
      let(:location) { instance_double(Location, longitude: nil, latitude: nil) }

      it "does return user location" do
        expect(interactor.current_location).to eq user.location
      end
    end

    context "when user location does not exists" do
      let(:location) { instance_double(Location, longitude: nil, latitude: nil) }
      let!(:user) { create :user, location: nil }

      it "does default location" do
        expect(interactor.current_location.city).to eq "Kazan"
      end
    end
  end
end
