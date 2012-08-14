[$, _, Backbone, Models, Collections, Views] = [@jQuery, @_, @Backbone, @Stoplight.Models, @Stoplight.Collections, @Stoplight.Views]

class Views.ProjectsList extends Backbone.View

  initialize: (options) ->
    @collection.on('reset', @render)
    @render()

  render: =>
    @collection.each(@_renderProjectListItem)
    this

  _renderProjectListItem: (item) =>
    view = new Views.ProjectListItem({model: item})
    @$el.append(view.render().el)
