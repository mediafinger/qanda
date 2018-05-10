# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :body, length: { in: 3..65535 }
  validates :title, length: { in: 3..255 }
end
