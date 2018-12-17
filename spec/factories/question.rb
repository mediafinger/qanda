# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { "Why?" }
    body { "Why did the lucky stiff disappear?" }
    user

    trait :markdown do
      title { "Did my markdown disappear?" }
      body do
        <<~MARKDOWN
          # Headline

          Some text in _italic_ and **bold**

          * bullet
          * points

          ## Lucky part

          A plain link: https://localhost:3000

          ---

          Line breaks
          Should be ignored

          Unless there is a blank line in between
        MARKDOWN
      end
    end
  end
end
