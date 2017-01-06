require "rails_helper"

describe FetchAuthorsNearby do
  describe ".call" do
    let!(:users) { create_list :user, 10 }

    let(:parsed_location) do
      {
        longitude: location.longitude,
        latitude: location.latitude,
        city: location.city
      }
    end
    subject(:interactor) { described_class.call(current_location: parsed_location) }

    context "when user exists in given location" do
      let(:location) { instance_double(Location, city: "Kazan", longitude: 49.122381, latitude: 55.790745) }

      it "does fetch users" do
        expect(interactor.authors).to include users.first
        expect(interactor.authors.count).to eq 10
      end
    end

    context "when user does not exists in given location" do
      let(:location) { instance_double(Location, city: "Elabuga", longitude: 52.019269, latitude: 55.777555) }

      it "does fetch users" do
        expect(interactor.authors).to_not include users.first
      end
    end
  end
end
