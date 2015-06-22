WEATHER.Views.Map = Backbone.View.extend
  initialize: (options) ->
    @el = $(@el)
    @template = _.template(WEATHER.Templates.map)

  render: ->
    @el.html @template()

  postRender: ->
    mapoptions =
      zoom: 15
      center: new google.maps.latlng(@model.geolocation.coords.latitude, @model.geolocation.coords.longitude)
      maptypeid: google.maps.maptypeid.satellite
      draggable: false
      zoomcontrol: false
      scrollwheel: false
      pancontrol: false
      streetviewcontrol: false
      maptypecontrol: false

    map = new google.maps.map(@el.find("#map")[0], mapoptions)
    google.maps.event.addlisteneronce map, "idle", ->
      $("#overlay").show()
