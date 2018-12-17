# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/NamedSubject
RSpec.shared_examples "validation failure" do
  it "does not initialize a record" do
    expect(subject.valid?).to be false
    expect(subject.errors.messages[field].join(",")).to match(error_message)
    expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
# rubocop:enable RSpec/NamedSubject
