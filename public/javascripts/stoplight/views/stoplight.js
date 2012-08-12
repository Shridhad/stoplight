(function() {
  var $, Backbone, Collections, Models, Views, _, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  _ref = [this.jQuery, this._, this.Backbone, this.Stoplight.Models, this.Stoplight.Collections, this.Stoplight.Views], $ = _ref[0], _ = _ref[1], Backbone = _ref[2], Models = _ref[3], Collections = _ref[4], Views = _ref[5];

  Views.Stoplight = (function(_super) {

    __extends(Stoplight, _super);

    function Stoplight() {
      this._setFontSizes = __bind(this._setFontSizes, this);

      this.render = __bind(this.render, this);

      this.initialize = __bind(this.initialize, this);
      return Stoplight.__super__.constructor.apply(this, arguments);
    }

    Stoplight.prototype.tagName = 'div';

    Stoplight.prototype.id = 'stoplight';

    Stoplight.prototype.initialize = function() {
      return $(window).on('resize', this._setFontSizes);
    };

    Stoplight.prototype.render = function() {
      var v;
      $('#mini-projects').empty();
      v = new MiniProjectsView({
        model: this.model,
        el: $('#mini-projects')
      });
      v.render();
      $('#projects-board').empty();
      v = new ProjectsBoardView({
        model: this.model,
        el: $('#projects-board')
      });
      v.render();
      return this._setFontSizes();
    };

    Stoplight.prototype._setFontSizes = function() {
      return $.each($('#projects-board .project'), function(index, element) {
        var $a, $element, $h1, $p, maxCharacterWidth;
        $element = $(element);
        $h1 = $element.find('h1');
        $a = $h1.find('a');
        $p = $element.find('p');
        maxCharacterWidth = ($element.width() / $a.html().length) * 1.5;
        $h1.css({
          fontSize: Math.min($element.height() / 4.0, maxCharacterWidth),
          marginTop: $element.height() / 3.0
        });
        return $p.css({
          fontSize: parseInt($h1.css('fontSize')) / 4.0
        });
      });
    };

    return Stoplight;

  })(Backbone.View);

}).call(this);
