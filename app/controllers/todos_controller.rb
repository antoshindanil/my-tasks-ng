# frozen_string_literal: true

class TodosController < ApplicationController
  def update
    todo = Todo.find(todo_params[:id])

    if todo.update(todo_params)
      @todo = todo
    else
      render_error(todo)
    end
  end

  def create
    if project_params[:id]
      project = Project.find_by(id: project_params[:id])

      create_project_todo(project)
    else
      project = Project.new(project_params)

      project.save ? create_project_todo(project) : render_error(project)
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:text, :is_completed, :project_id, :id)
  end

  def project_params
    params.require(:project).permit(:id, :title)
  end

  def create_project_todo(project)
    todo = project.todos.new(todo_params)

    if todo.save
      @projects = Project.includes(:todos).order("todos.id ASC")
      render "projects/index", projects: @projects, status: :ok
    else
      render json: { errors: todo.errors }, status: :bad_request
    end
  end

  def render_error(obj)
    render json: { errors: obj.errors }, status: :bad_request
  end
end
