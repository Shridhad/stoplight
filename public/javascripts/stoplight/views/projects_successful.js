(function() {
  var $, Backbone, Collections, Models, Views, _, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  _ref = [this.jQuery, this._, this.Backbone, this.Stoplight.Models, this.Stoplight.Collections, this.Stoplight.Views], $ = _ref[0], _ = _ref[1], Backbone = _ref[2], Models = _ref[3], Collections = _ref[4], Views = _ref[5];

  Views.SuccessfulTile = (function(_super) {

    __extends(SuccessfulTile, _super);

    function SuccessfulTile() {
      this.render = __bind(this.render, this);
      return SuccessfulTile.__super__.constructor.apply(this, arguments);
    }

    SuccessfulTile.prototype.tagName = 'div';

    SuccessfulTile.prototype.className = 'wrapper';

    SuccessfulTile.prototype.template = _.template("<article class=\"project success\">\n  <h1>\n    <a href=\"javascript:void();\">&#x2713; Hooray!</a>\n  </h1>\n  <p class=\"status\">All builds are passing!</p>\n</article>");

    SuccessfulTile.prototype.render = function() {
      this.$el.html(this.template({}));
      return this;
    };

    return SuccessfulTile;

  })(Backbone.View);

}).call(this);
