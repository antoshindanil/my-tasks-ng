# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectsController, type: :controller do
  describe "GET #index" do
    before do
      get :index, format: :json
    end

    it "render an array of projects" do
      expect((assigns(:projects))).to eq(Project.includes(:todos).order("todos.id ASC"))
    end

    it "render index view" do
      expect(response).to render_template :index
    end

    it "returns status code 200" do
      expect(response).to have_http_status(:success)
    end
  end
end
