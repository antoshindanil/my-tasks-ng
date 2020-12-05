# frozen_string_literal: true

class Todo < ApplicationRecord
  belongs_to :project

  validates :text, presence: true
  validates :is_completed, inclusion: { in: [true, false] }
end
