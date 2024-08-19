# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Workflow", type: :feature do
  # rubocop:disable RSpec/NoExpectationExample
  scenario "User logs in, asks a question, and logs out again" do
    login_with_invalid_credentials

    login_succesfully
    ask_a_question
    answer_a_question
    search_a_question

    logout
  end
  # rubocop:enable RSpec/NoExpectationExample

  # workflows
  #
  def login_with_invalid_credentials
    mock_omniauth_invalid

    visit "/"
    click_button "Please login with Google to continue"

    expect(page).to have_button("Please login with Google to continue")
  end

  def login_succesfully
    mock_omniauth
    click_button "Please login with Google to continue"

    expect(page).to have_text("Harry Potter")
    expect(page).to have_link("Logout")
    expect(page).to have_link("Questions")
    expect(page).to have_link("Ask Question")
  end

  def ask_a_question
    click_link "Ask Question"

    fill_in "question_title", with: "Why?"
    fill_in "question_body", with: "Why did the lucky stiff disappear? And where is he now?"
    click_button "Submit"

    expect(page).to have_text("Question was successfully created.")
    expect(page).to have_text("List of all questions")
    expect(page).to have_text("Why did the lucky stiff disappear? And where is he now?")
  end

  def answer_a_question
    click_link "Questions"
    click_link "Why?"

    fill_in "answer_title", with: "Because"
    fill_in "answer_body", with: "He could not handle his fame."
    click_button "Answer"

    expect(page).to have_text("Answer was successfully created.")
    expect(page).to have_text("Why did the lucky stiff disappear? And where is he now?")
    expect(page).to have_text("He could not handle his fame.")

    expect(page).not_to have_text("List of all questions")
  end

  #rubocop:disable Metrics/AbcSize
  def search_a_question
    click_link "Search"

    expect(page).to have_field("search_in_titles", checked: true)
    expect(page).to have_field("search_in_bodies", checked: true)
    expect(page).to have_field("find_any_word", checked: true)

    uncheck "search_in_bodies"
    uncheck "find_any_word"
    fill_in "query", with: "the lucky stiff"
    click_button "Search"

    expect(page).to have_text("No search results for query: the lucky stiff")
    expect(page).to have_field("search_in_titles", checked: true)
    expect(page).to have_field("search_in_bodies", checked: true)
    expect(page).to have_field("find_any_word", checked: false)
    expect(page).to have_field("query", with: "the lucky stiff")

    click_button "Search"

    expect(page).to have_text("Your search results")
    expect(page).to have_text("Why did the lucky stiff disappear? And where is he now?")
  end
  #rubocop:enable Metrics/AbcSize

  def logout
    click_link "Logout"
    expect(page).to have_button("Please login with Google to continue")
  end

  # helper methods
  #
  def mock_omniauth
    # Short circuit OmniAuth to return default value to callback URL
    OmniAuth.config.test_mode = true

    # Set a default mock for the auth hash
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      uid: "123456",
      info: {
        email: "harry@example.com",
        image: "http://localhost:3000/harry_potter.png",
        name: "Harry Potter",
      },
      credentials: { token: "foobarbaz" },
    })
  end

  def mock_omniauth_invalid
    # Short circuit OmniAuth to return default value to callback URL
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials

    # Do not raise an exception when credentials are invalid
    OmniAuth.config.on_failure = proc { |env|
      OmniAuth::FailureEndpoint.new(env).redirect_to_failure
    }
  end
end
