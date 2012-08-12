(function() {
  var $, Backbone, Collections, Models, Views, _, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  _ref = [this.jQuery, this._, this.Backbone, this.Stoplight.Models, this.Stoplight.Collections, this.Stoplight.Views], $ = _ref[0], _ = _ref[1], Backbone = _ref[2], Models = _ref[3], Collections = _ref[4], Views = _ref[5];

  Views.ProjectTileView = (function(_super) {

    __extends(ProjectTileView, _super);

    function ProjectTileView() {
      this.render = __bind(this.render, this);
      return ProjectTileView.__super__.constructor.apply(this, arguments);
    }

    ProjectTileView.prototype.tagName = 'div';

    ProjectTileView.prototype.className = 'wrapper';

    ProjectTileView.prototype.template = _.template("<article class=\"project {{ last_build_status }} {{ current_status }}\">\n  <h1>\n    <a href=\"{{ build_url }}\" target=\"_TOP\"><%= name %></a>\n  </h1>\n  <p class=\"status\">\n    Build {{ last_build_id }} <strong>{{ last_build_status }}</strong>\n    <time class=\"build-time invisible\" datetime=\"{{ last_build_time }}\" title=\"{{ human_last_build_time }}\">\n      {{ human_last_build_time }}\n    </time>\n  </p>\n</article>");

    ProjectTileView.prototype.render = function() {
      this.$el.append(this.template(this.model.toJSON()));
      return this;
    };

    return ProjectTileView;

  })(Backbone.View);

}).call(this);
