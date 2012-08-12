(function() {
  var $, Backbone, Collections, Models, ProjectsSuccessView, Views, _, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  _ref = [this.Jquery, this._, this.Backbone, this.Stoplight.Models, this.Stoplight.Collections, this.Stoplight.Views], $ = _ref[0], _ = _ref[1], Backbone = _ref[2], Models = _ref[3], Collections = _ref[4], Views = _ref[5];

  ProjectsSuccessView = (function(_super) {

    __extends(ProjectsSuccessView, _super);

    function ProjectsSuccessView() {
      this.render = __bind(this.render, this);
      return ProjectsSuccessView.__super__.constructor.apply(this, arguments);
    }

    ProjectsSuccessView.prototype.tagName = 'div';

    ProjectsSuccessView.prototype.id = 'projects-board';

    ProjectsSuccessView.prototype.template = _.template("<article class=\"project success\">\n  <h1>\n    <a href=\"javascript:void();\">&#x2713; Hooray!</a>\n  </h1>\n  <p class=\"status\">All builds are passing!</p>\n</article>");

    ProjectsSuccessView.prototype.render = function() {
      var columns, failed_projects, h, rows, size, v, w,
        _this = this;
      failed_projects = this.model.where({
        last_build_status: 'failed'
      });
      if (failed_projects.length === 0) {
        v = new ProjectSuccessTileView;
        this.$el.html(v.render());
      } else {
        size = failed_projects.length;
        columns = size > 21 ? 4.0 : size > 10 ? 3.0 : size > 3 ? 2.0 : 1.0;
        rows = Math.ceil(size / columns);
        rows = Math.max(rows, 1.0);
        w = 100.0 / columns;
        h = 100.0 / rows;
        failed_projects.forEach(function(p) {
          v = new ProjectTileView({
            model: p,
            width: w,
            height: h
          });
          v.render();
          return _this.$el.append(v.el);
        });
      }
      return this.el;
    };

    return ProjectsSuccessView;

  })(Backbone.View);

}).call(this);
