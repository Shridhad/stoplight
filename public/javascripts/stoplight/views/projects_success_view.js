(function() {
  var $, Backbone, Collections, Models, Views, _, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  _ref = [this.Jquery, this._, this.Backbone, this.Stoplight.Models, this.Stoplight.Collections, this.Stoplight.Views], $ = _ref[0], _ = _ref[1], Backbone = _ref[2], Models = _ref[3], Collections = _ref[4], Views = _ref[5];

  Views.ProjectsSuccessful = (function(_super) {

    __extends(ProjectsSuccessful, _super);

    function ProjectsSuccessful() {
      this.setDisplay = __bind(this.setDisplay, this);

      this.render = __bind(this.render, this);
      return ProjectsSuccessful.__super__.constructor.apply(this, arguments);
    }

    ProjectsSuccessful.prototype.tagName = 'div';

    ProjectsSuccessful.prototype.id = 'projects-board';

    ProjectsSuccessful.prototype.template = _.template("<article class=\"project success\">\n  <h1>\n    <a href=\"javascript:void();\">&#x2713; Hooray!</a>\n  </h1>\n  <p class=\"status\">All builds are passing!</p>\n</article>");

    ProjectsSuccessful.prototype.initialize = function(options) {
      this.collection.on('reset', this.setDisplay);
      return this.render();
    };

    ProjectsSuccessful.prototype.render = function() {
      this.$el.append(this.template({}));
      this.setDisplay();
      return this;
    };

    ProjectsSuccessful.prototype.setDisplay = function() {
      var successView;
      successView = this.$el.find('.success');
      if (this.collection.success) {
        successView.show();
      } else {
        successView.hide();
      }
      return this;
    };

    return ProjectsSuccessful;

  })(Backbone.View);

}).call(this);
