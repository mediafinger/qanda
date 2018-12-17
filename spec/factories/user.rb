# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "harry-#{n}@example.com" }
    name { "Harry" }
    provider { "google" }
    sequence(:provider_uid, 1000) { |n| n }
  end
end
