# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :body, length: { in: 3..65535 }
  validates :title, length: { in: 3..255 }
end
