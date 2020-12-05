# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    project
    text { "MyString" }
    is_completed { false }
  end
end
