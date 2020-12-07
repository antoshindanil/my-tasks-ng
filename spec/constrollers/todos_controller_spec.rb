# frozen_string_literal: true

require "rails_helper"

RSpec.describe TodosController, type: :controller do
  describe "PATCH #update" do
    let!(:project) { create :project }
    let!(:todo) { create :todo, project: project }

    context "with valid attributes" do
      it "changes todo attributes" do
        patch :update, format: :json, params: { todo: { id: todo.id, text: todo.text, is_completed: !todo.is_completed },
                                                project: { id: project.id },
                                                todos_id: todo.id,
                                                id: project.id }
        expect(Todo.find_by(id: todo.id).is_completed).to eq(!todo.is_completed)
      end

      it "render template status code" do
        patch :update, format: :json, params: { todo: { id: todo.id, text: todo.text, is_completed: !todo.is_completed },
                                                project: { id: project.id },
                                                todos_id: todo.id,
                                                id: project.id }
        expect(response.status).to render_template :update
      end
    end

    context "with invalid attributes" do
      it "doesnt change todo attributes" do
        patch :update, params: { todo: { id: todo.id, text: "", is_completed: "" },
                                 project: { id: project.id },
                                 todos_id: todo.id,
                                 id: project.id }
        json = JSON.parse(response.body)
        expect(json["is_completed"]).not_to eq(!todo.is_completed)
      end

      it "return 400 status code" do
        patch :update, params: { todo: { id: todo.id, text: "", is_completed: "" },
                                 project: { id: project.id },
                                 todos_id: todo.id,
                                 id: project.id }
        expect(response.status).to eq 400
      end
    end
  end

  describe "POST #create" do
    let!(:project) { create :project }

    context "with existed project" do
      it "saves new todo in the database" do
        expect {
          post :create,
               params: { todo: { text: "New text", is_completed: false }, project: { id: project.id } }
        }.to change(Todo, :count).by(1)
      end

      it "return 200 status code" do
        post :create,
             params: { todo: { text: "New text", is_completed: false }, project: { id: project.id } }
        expect(response.status).to eq 200
      end
    end

    context "with not existed project" do
      it "saves new project in the database" do
        expect {
          post :create,
               params: { todo: { text: "New text", is_completed: false }, project: { title: "New title" } }
        }.to change(Project, :count).by(1)
      end

      it "saves new todo in the database" do
        expect {
          post :create,
               params: { todo: { text: "New text", is_completed: false }, project: { title: "New title" } }
        }.to change(Todo, :count).by(1)
      end

      it "return 200 status code" do
        post :create,
             params: { todo: { text: "New text", is_completed: false }, project: { title: "New title" } }
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      it "does not save the project" do
        expect {
          post :create,
               params: { todo: { text: "New text", is_completed: false }, project: { title: "" } }
        }.not_to change(Project, :count)
      end

      it "return error status" do
        post :create,
             params: { todo: { text: "New text", is_completed: false }, project: { title: "" } }
        expect(response.status).to eq 400
      end
    end
  end
end
