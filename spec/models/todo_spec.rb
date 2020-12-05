# frozen_string_literal: true

require "rails_helper"

RSpec.describe Todo, type: :model do
  describe "associations" do
    it { should validate_presence_of :text }
    it { should validate_inclusion_of(:is_completed).in_array([true, false]) }
  end

  describe "validations" do
    it { should belong_to(:project) }
  end
end
