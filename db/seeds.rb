error_msg = "Seed file not found!"
path_to_seed = Rails.root.join('db', 'seeds', 'projects.yml')
seed_file = File.exists?(path_to_seed) ? YAML.load_file(path_to_seed) : puts(error_msg)
projects = ActiveSupport::HashWithIndifferentAccess.new(seed_file)[:projects]

projects.each do |project| 
  created_project = Project.create!({title: project[:title]})

  project[:todos].each do |todo|
    created_project.todos.create!({ 
      text: todo[:text],
      is_completed: todo[:isCompleted]
    })
  end

  puts("Project with title: #{created_project.title} was added into database")
  
end
