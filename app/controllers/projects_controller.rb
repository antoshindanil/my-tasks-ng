# frozen_string_literal: true

class ProjectsController < ApplicationController
  def index
    @projects = Project.includes(:todos).order("todos.id ASC")
  end
end
