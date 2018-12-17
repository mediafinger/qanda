# frozen_string_literal: true

require "rails_helper"
require "support/validation_failure"

RSpec.describe Answer, type: :model do
  describe ".create" do
    subject(:answer) do
      described_class.new(
        user: user,
        question: question,
        body: body,
        title: title
      )
    end

    let(:user)     { FactoryBot.create(:user) }
    let(:question) { FactoryBot.create(:question) }
    let(:title)    { "Because!" }
    let(:body)     { "That's how it is." }

    context "when all validations pass" do
      it { expect(answer).to be_valid }
    end

    context "when the User does not exist in the database" do
      let(:user)          { FactoryBot.build(:user) }
      let(:question)      { FactoryBot.create(:question) }
      let(:field)         { :user_id }
      let(:error_message) { /can't be blank/ }

      it_behaves_like "validation failure"
    end

    context "when the Question does not exist" do
      let(:question)      { nil }
      let(:field)         { :question_id }
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
