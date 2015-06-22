WEATHER.Views.Forecast = Backbone.View.extend(
  id: "forecast"
  initialize: ->
    @el = $(@el)
    @template = _.template(WEATHER.Templates.forecast)

  render: ->
    forecast = @model.toJSON()
    $(@el).html @template

    _.each forecast, ((day) ->
      @el.find("#forecastContainer").append _.template(WEATHER.Templates.forecastDay, day)
    ), @

    @
)
