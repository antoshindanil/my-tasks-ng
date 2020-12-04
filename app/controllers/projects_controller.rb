# frozen_string_literal: true

class ProjectsController < ApplicationController
  def index
    render json: { message: "ok" }
  end
end
