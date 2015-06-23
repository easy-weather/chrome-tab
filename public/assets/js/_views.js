(function() {
  WEATHER.Views.App = Backbone.View.extend({
    initialize: function(options) {
      this.el = $(this.el);
      this.template = _.template(WEATHER.Templates.app);
      if (options.appDelegate) {
        this.appDelegate = options.appDelegate;
      }
      if (options.model) {
        this.model = options.model;
        return this.model.on("geoLocationFound", (function(_this) {
          return function() {
            return _this.positionAcquired();
          };
        })(this));
      }
    },
    positionAcquired: function() {
      this.mapView = new WEATHER.Views.Map({
        model: this.model,
        appDelegate: this
      });
      this.mapView.render();
      $("body").append(this.mapView.el);
      return this.mapView.postRender();
    },
    render: function() {
      this.el.html(this.template());
      if (this.model.activeView) {
        this.model.activeView.appDelegate = this;
        this.model.activeView.render();
        return this.el.find("#content").html(this.model.activeView.el);
      }
    },
    renderSecondView: function() {
      if (this.model.secondView) {
        this.model.secondView.appDelegate = this;
        this.model.secondView.render();
        return this.el.find("#content").append(this.model.secondView.el);
      }
    },
    postRender: function() {}
  });

}).call(this);

(function() {
  WEATHER.Views.Conditions = Backbone.View.extend({
    id: "conditions",
    initialize: function() {
      this.el = $(this.el);
      return this.template = _.template(WEATHER.Templates.conditions);
    },
    render: function() {
      var conditions;
      conditions = this.model.models[0].toJSON();
      $(this.el).html(this.template(conditions));
      return this;
    }
  });

}).call(this);

(function() {
  WEATHER.Views.Forecast = Backbone.View.extend({
    id: "forecast",
    initialize: function() {
      this.el = $(this.el);
      return this.template = _.template(WEATHER.Templates.forecast);
    },
    render: function() {
      var forecast;
      forecast = this.model.toJSON();
      $(this.el).html(this.template);
      _.each(forecast, (function(day) {
        return this.el.find("#forecastContainer").append(_.template(WEATHER.Templates.forecastDay, day));
      }), this);
      return this;
    }
  });

}).call(this);

(function() {
  WEATHER.Views.Home = Backbone.View.extend({
    id: "home",
    initialize: function() {
      this.el = $(this.el);
      return this.template = _.template(WEATHER.Templates.conditions);
    },
    render: function() {
      var conditions;
      console.log(this.model.models[0].toJSON());
      conditions = this.model.models[0].toJSON();
      $(this.el).html(this.template(conditions));
      return this;
    }
  });

}).call(this);

(function() {
  var initialize, postRender, render;

  WEATHER.Views.Loading = Backbone.View.extend(initialize = function() {
    this.el = $(this.el);
    return this.template = _.template(WEATHER.Templates.loading);
  }, render = function() {
    return this.el.html(this.template());
  }, postRender = function() {});

}).call(this);

(function() {
  WEATHER.Views.Map = Backbone.View.extend({
    initialize: function(options) {
      this.el = $(this.el);
      return this.template = _.template(WEATHER.Templates.map);
    },
    render: function() {
      return this.el.html(this.template());
    },
    postRender: function() {
      var apiKey;
      apiKey = "AIzaSyBf1n3GL-Kv1e4He0qkluxKpiCfrOWYVvI";
      $("#mapc").css("background-image", "url(https://maps.googleapis.com/maps/api/staticmap?center=" + this.model.geoLocation.coords.latitude + "," + this.model.geoLocation.coords.longitude + "&scale=2&maptype=satellite&size=640x640&zoom=15&key=" + apiKey + ")");
      return $("#overlay").show();
    }
  });

}).call(this);
