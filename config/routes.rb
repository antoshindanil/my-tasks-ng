# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    root "projects#index"

    get "projects", to: "projects#index"
  end
end
