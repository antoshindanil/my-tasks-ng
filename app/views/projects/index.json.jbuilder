json.array! @projects do |_project|
  json.partial! partial: "projects/project", locals: { project: _project }
end
