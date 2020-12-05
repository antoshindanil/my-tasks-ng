# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :todos, dependent: :destroy

  validates :title, presence: true
end
