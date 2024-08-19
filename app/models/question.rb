# frozen_string_literal: true

class Question < ApplicationRecord
  include PgSearch::Model

  ALLOWED_SEARCH_FIELDS = %i(body title).freeze

  # documentation: https://github.com/Casecommons/pg_search
  # some commented out lines have been left in here, as this are features I would love to add next
  pg_search_scope :search_for, lambda { |fields, query, find_any|
    raise ArgumentError, "Array expected, 'fields' was: #{fields}" unless fields.is_a?(Array)
    raise ArgumentError, "String expected, 'query' was: #{query}" unless query.is_a?(String)
    raise ArgumentError, "query too short, min 3 characters expected" unless query.length >= 3
    raise ArgumentError, "query too long, max 100 characters allowed" unless query.length <= 100

    allowed_fields = fields.select { |field| ALLOWED_SEARCH_FIELDS.include?(field) }
    raise ArgumentError, "Expected 'fields' to contain at least one of #{ALLOWED_SEARCH_FIELDS}" if allowed_fields.empty?

    {
      against: allowed_fields,
      query:,
      # ignoring: :accents, # needs migration to enable_extension 'unaccent'
      using: {
        tsearch: {
          any_word: !!find_any,
          # negation: true,        # this seems to be incompatible with :any_word or dictionary: "english"
          # dictionary: "english", # this would allow for stemming, but does not allow to find terms like "why"
          # tsvector_column: fields.map { |field| "#{field}_tsvector" }, # config.active_record.schema_format = :sql
        },
      },
    }
  }

  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :user_id, presence: true
  validates :body, length: { in: 3..65535 }
  validates :title, length: { in: 3..255 }
end
