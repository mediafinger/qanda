# frozen_string_literal: true

class Question < ApplicationRecord
  include PgSearch

  ALLOWED_SEARCH_FIELDS = %i[body title].freeze

  pg_search_scope :search_for, lambda { |fields, query|
    raise ArgumentError, "Array expected, 'fields' was: #{fields}" unless fields.is_a?(Array)
    raise ArgumentError, "String expected, 'query' was: #{query}" unless query.is_a?(String)
    raise ArgumentError, "query too short, min 3 characters expected" unless query.length >= 3
    raise ArgumentError, "query too long, max 100 characters allowed" unless query.length <= 100

    allowed_fields = fields.select { |field| ALLOWED_SEARCH_FIELDS.include?(field) }
    raise ArgumentError, "Expected 'fields' to contain at least one of #{ALLOWED_SEARCH_FIELDS}" if allowed_fields.empty?

    { against: allowed_fields, query: query }
  }

  belongs_to :user
  has_many :answers

  validates :user_id, presence: true
  validates :body, length: { in: 3..65535 }
  validates :title, length: { in: 3..255 }
end
