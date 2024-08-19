# frozen_string_literal: true

require "rails_helper"
require "support/validation_failure"

RSpec.describe Question, type: :model do
  describe ".create" do
    subject(:question) { FactoryBot.build(:question, user:, body:, title:) }

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

  describe ".search_for" do
    subject(:search) { described_class.search_for(fields, query, find_any) }

    let(:find_any)   { true }

    let!(:question_1) { FactoryBot.create(:question) }
    let!(:question_2) { FactoryBot.create(:question, :markdown) }

    context "when the query string is part of a title" do
      let(:query) { "markdown" }

      context "when searched in titles" do
        let(:fields) { [:title] }

        it { expect(search).to eq [question_2] }
      end

      context "when searched in bodies and titles" do
        let(:fields) { [:body, :title] }

        it { expect(search).to eq [question_2] }
      end

      context "when searched in bodies" do
        let(:fields) { [:body] }

        it { expect(search).to eq [] }
      end
    end

    context "when the query string is part of a body" do
      let(:query) { "stiff" }

      context "when searched in titles" do
        let(:fields) { [:title] }

        it { expect(search).to eq [] }
      end

      context "when searched in bodies and titles" do
        let(:fields) { [:body, :title] }

        it { expect(search).to eq [question_1] }
      end

      context "when searched in bodies" do
        let(:fields) { [:body] }

        it { expect(search).to eq [question_1] }
      end
    end

    context "when the query string is part of a title and a body" do
      let(:query) { "disappear" }

      context "when searched in titles" do
        let(:fields) { [:title] }

        it { expect(search).to eq [question_2] }
      end

      context "when searched in bodies and titles" do
        let(:fields) { [:body, :title] }

        it { expect(search).to contain_exactly(question_1, question_2) }
      end

      context "when searched in bodies" do
        let(:fields) { [:body] }

        it { expect(search).to eq [question_1] }
      end
    end

    context "when the query string is part of title and body of one question" do
      let(:query) { "why" }

      context "when searched in titles" do
        let(:fields) { [:title] }

        it { expect(search).to eq [question_1] }
      end

      context "when searched in bodies and titles" do
        let(:fields) { [:body, :title] }

        it { expect(search).to contain_exactly(question_1) }
      end

      context "when searched in bodies" do
        let(:fields) { [:body] }

        it { expect(search).to eq [question_1] }
      end
    end

    context "when searching for multiple words" do
      let(:fields) { [:body, :title] }
      let(:query) { "lucky stiff" }

      context "when expecting the result to contain all words" do
        let(:find_any) { false }

        it { expect(search).to eq [question_1] }
      end

      context "when expecting the result to contain any word" do
        let(:find_any) { true }

        it { expect(search).to contain_exactly(question_1, question_2) }
      end
    end

    # tsearch: { negation: true } # this seems to be incompatible with :any_word or dictionary: "english"
    xcontext "when excluding search terms from result" do
      let(:fields)   { [:body, :title] }
      let(:find_any) { false }
      let(:query)    { "disappear !lucky" }

      it { expect(search.to_a).to contain_exactly(question_2) }
    end

    # tsearch: { dictionary: "english" } # this would allow for stemming, but does not allow to find terms like "why"
    xcontext "when searching with similar forms (stemming support)" do
      let(:fields)   { [:body, :title] }
      let(:find_any) { false }
      let(:query)    { "student teachers joining swim" }

      let!(:question_3) do
        FactoryBot.create(
          :question,
          title: "Any students want to join me?",
          body: "There will be swimming lessons with a teacher."
        )
      end

      it { expect(search).to eq [question_3] }
    end

    context "when passing invalid parameters" do
      context "when fields is not an array" do
        let(:fields) { :body }
        let(:query)  { "anything" }

        it { expect { search }.to raise_error(ArgumentError, "Array expected, 'fields' was: #{fields}") }
      end

      context "when fields does not contain allowed fields" do
        let(:fields) { [:user, :id] }
        let(:query)  { "anything" }

        it "raises an error message containing the allowed fields" do
          expect { search }.to raise_error(
            ArgumentError, "Expected 'fields' to contain at least one of #{described_class::ALLOWED_SEARCH_FIELDS}"
          )
        end
      end

      context "when query is not a string" do
        let(:fields) { [:body, :title] }
        let(:query)  { 123 }

        it { expect { search }.to raise_error(ArgumentError, "String expected, 'query' was: #{query}") }
      end

      context "when query is too short" do
        let(:fields) { [:body, :title] }
        let(:query)  { "ab" }

        it { expect { search }.to raise_error(ArgumentError, "query too short, min 3 characters expected") }
      end

      context "when query is too long" do
        let(:fields) { [:body, :title] }
        let(:query)  { "why " * 26 }

        it { expect { search }.to raise_error(ArgumentError, "query too long, max 100 characters allowed") }
      end
    end
  end
end
