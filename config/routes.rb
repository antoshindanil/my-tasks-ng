# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    root "projects#index"

    get "projects", to: "projects#index"
    post "projects/todos", to: "todos#create"
    patch "projects/:id/todos/:todos_id", to: "todos#update", as: :update_todo
  end
end
