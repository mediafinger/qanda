# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe ".find_or_create_from" do
    subject(:user) { described_class.find_or_create_from(auth) }

    let(:auth) do
      {
        info: {
          email: "harry@example.com",
          name: "Harry Potter",
          image: "http://localhost:3000/harry_potter.png",
        },
        provider: "Google",
        uid: "1234",
      }
    end

    context "when creation successful" do
      it { expect { user }.to change { User.count }.by(1) }

      it { expect(user.email).to        eq(auth.dig(:info, :email)) }
      it { expect(user.name).to         eq(auth.dig(:info, :name)) }
      it { expect(user.image).to        eq(auth.dig(:info, :image)) }
      it { expect(user.provider).to     eq(auth[:provider]) }
      it { expect(user.provider_uid).to eq(auth[:uid]) }
    end

    context "when retrieval successful" do
      let!(:user_1) do
        described_class.create!(provider: auth[:provider], provider_uid: auth[:uid], name: "Harry", email: "h@example.com")
      end

      it { expect { user }.not_to change { User.count } }
      it { expect(user.id).to eq(user_1.id) }

      it "updates current user information" do
        expect(user.email).to eq(auth.dig(:info, :email))
        expect(user.name).to  eq(auth.dig(:info, :name))
        expect(user.image).to eq(auth.dig(:info, :image))
      end
    end

    context "when it fails" do
      let(:auth) { {} }

      it { expect { user }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
