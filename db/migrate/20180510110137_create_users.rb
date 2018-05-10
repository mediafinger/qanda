# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :name
      t.string :image
      t.string :provider
      t.string :provider_uid

      t.timestamps
    end
  end
end
