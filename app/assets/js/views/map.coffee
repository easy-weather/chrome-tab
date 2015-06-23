WEATHER.Views.Map = Backbone.View.extend
  initialize: (options) ->
    @el = $(@el)
    @template = _.template(WEATHER.Templates.map)

  render: ->
    @el.html @template()

  postRender: ->
    apiKey = "AIzaSyBf1n3GL-Kv1e4He0qkluxKpiCfrOWYVvI"
    $("#mapc").css("background-image", "url(https://maps.googleapis.com/maps/api/staticmap?center="+@model.geoLocation.coords.latitude+","+@model.geoLocation.coords.longitude+"&scale=2&maptype=satellite&size=640x640&zoom=15&key="+apiKey+")")
    $("#overlay").show()
