[$, _, Backbone, Models, Collections, Views] = [@jQuery, @_, @Backbone, @Stoplight.Models, @Stoplight.Collections, @Stoplight.Views]

class Views.ProjectListItem extends Backbone.View
  tagName: 'div'
  className: 'project-list-item'

  events: {
   "click .ignore" : "_toggleIgnore"
  }

  initialize: (options)->
    @model.on('change:ignored', @render)

  template: _.template(
    """
      <a href="{{ build_url }}" class="project {{ last_build_status }} {{ current_status }} {{ ignored_klass }}" target="_TOP">
        {{ name }}
        <time class="last-build-time invisible" datetime="{{ last_build_time }}" title="{{ human_last_build_time }}">
          {{ human_last_build_time }}
        </time>
      </a>
      <button class="ignore"></button>
    """)

  render:()=>
    @$el.html @template(@model.toJSON())

    this

  _toggleIgnore: =>
    @model.toggleIgnore()
