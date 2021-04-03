# frozen_string_literal: true

class User < ApplicationRecord
  has_many :answers, dependent: :nullify
  has_many :questions, dependent: :nullify

  validates :email, presence: true
  validates :name, presence: true
  validates :provider, presence: true
  validates :provider_uid, presence: true

  def self.find_or_create_from(auth)
    where(provider: auth[:provider], provider_uid: auth[:uid]).first_or_initialize.tap do |user|
      user.email        = auth.dig(:info, :email)
      user.name         = auth.dig(:info, :name)
      user.image        = auth.dig(:info, :image)
      user.provider     = auth[:provider]
      user.provider_uid = auth[:uid]

      user.save!
    end
  end
end
