# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "validation failure" do
  it "does not initialize a Question" do
    expect(question.valid?).to be false
    expect(question.errors.messages[field].join(",")).to match(error_message)
    expect { question.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end

RSpec.describe Question, type: :model do
  describe ".create" do
    subject(:question) { FactoryBot.build(:question, user: user, body: body, title: title) }

    let(:user)  { FactoryBot.create(:user) }
    let(:title) { "Why?" }
    let(:body)  { "Why did the lucky stiff disappear?" }

    context "when all validations pass" do
      it { expect(question).to be_valid }
    end

    context "when the User does not exist" do
      let(:user)          { User.new(name: "John Doe") }
      let(:field)         { :user_id }
      let(:error_message) { /can't be blank/ }

      it_behaves_like "validation failure"
    end

    context "when no title is given" do
      let(:title)         { nil }
      let(:field)         { :title }
      let(:error_message) { /too short/ }

      it_behaves_like "validation failure"
    end

    context "when the body is too short" do
      let(:body)          { "oh" }
      let(:field)         { :body }
      let(:error_message) { /too short/ }

      it_behaves_like "validation failure"
    end
  end
end
