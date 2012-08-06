(function() {
  var refresh_data, render_all, v;

  v = new StoplightView({
    model: Projects
  });

  refresh_data = function() {
    return Projects.fetch({
      success: function() {
        return v.render();
      }
    });
  };

  render_all = function() {
    var p;
    p = Projects.first();
    $('body').append(v.el);
    v.render();
    return setInterval(refresh_data, 5 * 1000);
  };

  Projects.fetch({
    success: render_all
  });

}).call(this);
