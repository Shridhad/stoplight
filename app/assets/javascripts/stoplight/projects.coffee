[$, _, Backbone, Models, Collections] = [@Jquery, @_, @Backbone, @Stoplight.Models, @Stoplight.Collections]

class Collections.Projects extends Backbone.Collection
  model: Models.Project
  url: '/projects.json'

  comparator: (project)->
    new Date(project.get('last_build_time')).getTime()*-1

  failing_watched_projects: ->
    @where({last_build_status: 'failed', ignored: false})

  success: ->
    @failing_watched_projects().length is 0
