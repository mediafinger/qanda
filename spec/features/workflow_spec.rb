# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Workflow", type: :feature do
  before do
  end

  scenario "User logs in, asks a question, and logs out again" do
    login_with_invalid_credentials

    login_succesfully
    ask_a_question
    answer_a_question

    logout
  end

  # workflows
  #
  def login_with_invalid_credentials
    mock_omniauth_invalid

    visit "/"
    click_link "Please login with Google to continue"

    expect(page).to have_link("Please login with Google to continue")
  end

  def login_succesfully
    mock_omniauth
    click_link "Please login with Google to continue"

    expect(page).to have_text("Harry Potter")
    expect(page).to have_link("Logout")
    expect(page).to have_link("Questions")
    expect(page).to have_link("Ask Question")
  end

  def ask_a_question
    click_link "Ask Question"

    fill_in "title", with: "Why?"
    fill_in "body", with: "Why did the lucky stiff disappear? And where is he now?"
    click_button "Submit"

    expect(page).to have_text("Question was successfully created.")
    expect(page).to have_text("List of all questions")
    expect(page).to have_text("Why did the lucky stiff disappear? And where is he now?")
  end

  def answer_a_question
    click_link "Questions"
    click_link "Why?"

    fill_in "title", with: "Because"
    fill_in "body", with: "He could not handle his fame."
    click_button "Answer"

    expect(page).to have_text("Why did the lucky stiff disappear? And where is he now?")
    expect(page).to have_text("He could not handle his fame.")

    expect(page).not_to have_text("List of all questions")
  end

  def logout
    click_link "Logout"
    expect(page).to have_link("Please login with Google to continue")
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
