configure {
  set :root, File.dirname(__FILE__)
}

#
# GET /
#
# Load the static HTML file
#
get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

#
# GET /projects.json
#
# Load the initial build screen
#
get '/projects.json' do
  load_projects

  content_type 'application/json'
  render :rabl, :index, :format => 'json'
end

#
# GET '/:project_name'
#
# Returns a PNG corresponding to the current build status
#
get '/:project_name.png' do |project_name|
  load_projects

  project = @projects.find { |project| project.name == project_name }

  unless project.nil?
    # if the project is done, show the status, otherwise, show it's building
    project_state = project.built? ? project.last_build_status : project.current_status

    image = case project_state
      when 'passed' then 'passing'
      when 'failed' then 'failing'
      else 'unknown'
    end

    content_type 'image/png'
    File.read("./public/images/status/#{image}.png")
  else
    status 404
  end
end


private
# Load the servers and projects from the YAML file
def load_projects
  @servers ||= YAML::load(File.read('config/servers.yml'))

  @projects = @servers.collect do |server|
    Thread.new do
      server_projects = Timeout::timeout(5) do
        get_server(server).projects
      end

      # if server['projects'] is defined, we only want those projects
      Thread.current['projects'] = if server['projects']
        regexes = collect_regexes(server['projects'])
        server_projects.select { |server_project|
          regexes.any?{ |regex| server_project.name =~ regex }
        }
      elsif server['ignored_projects']
        regexes = collect_regexes(server['ignored_projects'])
        server_projects.reject { |server_project|
          regexes.any?{ |regex| server_project.name =~ regex }
        }
      else
        server_projects
      end
    end
  end.map(&:join).collect{ |t| t['projects'] }.compact.flatten.sort
end

def collect_regexes(projects)
  projects.collect do |j|
    if j =~ %r{^/.*/$}
      Regexp.new(j[1..(j.size-2)])
    else
      Regexp.new("^#{Regexp.escape(j)}$")
    end
  end
end

# Attemps to find the class associated with a given server type.
# Throws an exception if the class is not found
def get_server(server)
  server_type = server['type'].camelize
  begin
    klass = "Stoplight::Providers::#{server_type}".constantize
  rescue NameError => e
    raise Stoplight::Exceptions::UnknownProviderError, "Could not load provider with class name `#{server_type}`"
  end

  klass.new(server)
end
