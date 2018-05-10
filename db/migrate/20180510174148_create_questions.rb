# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, index: true
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
