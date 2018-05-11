# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples "validation failure" do
  it "does not initialize a Answer" do
    expect(answer.valid?).to be false
    expect(answer.errors.messages[field].join(",")).to match(error_message)
    expect { answer.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end

RSpec.describe Answer, type: :model do
  describe ".create" do
    subject(:answer) { described_class.new(params) }

    let(:params) do
      {
        user: user,
        question: question,
        body: body,
        title: title,
      }
    end

    let(:user)     { User.create!(name: "Harry", email: "harry@example.com", provider: "google", provider_uid: "1234") }
    let(:question) { Question.create!(user_id: user.id, title: "Why?", body: "Can anybody tell me?") }
    let(:title)    { "Because!" }
    let(:body)     { "That's how it is." }

    context "when all validations pass" do
      it { expect(answer).to be_valid }
    end

    context "when the User does not exist" do
      let(:user)          { User.new(name: "John Doe") }
      let(:question)      { Question.new(user_id: user.id, title: "Why?", body: "Can anybody tell me?") }
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
