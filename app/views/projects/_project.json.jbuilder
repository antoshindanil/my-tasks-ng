json.id project.id
json.title project.title

json.todos project.todos do |todo|
  json.id todo.id
  json.text todo.text
  json.is_completed todo.is_completed
end
