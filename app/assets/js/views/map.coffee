WEATHER.Views.Map = Backbone.View.extend
  initialize: (options) ->
    @el = $(@el)
    @template = _.template(WEATHER.Templates.map)

  render: ->
    @el.html @template()

  convertImgToBase64URL: (url, callback, outputFormat) ->
    img = new Image()
    img.crossOrigin = 'Anonymous'
    img.onload = () ->
      canvas = document.createElement 'CANVAS'
      ctx = canvas.getContext '2d'
      canvas.height = this.height
      canvas.width = this.width
      ctx.drawImage this,0,0
      dataURL = canvas.toDataURL outputFormat || 'image/png'
      callback dataURL
      canvas = null

    img.src = url

  renderMap: (dataURL) ->
    $("#mapc").css("background-image", "url(" + dataURL+ ")")
    $("#overlay").show()

  postRender: ->
    apiKey = "AIzaSyBf1n3GL-Kv1e4He0qkluxKpiCfrOWYVvI"
    url = "https://maps.googleapis.com/maps/api/staticmap?center="+@model.geoLocation.coords.latitude+","+@model.geoLocation.coords.longitude+"&scale=2&maptype=satellite&size=640x640&zoom=15&key="+apiKey

    forceServer = true

    if Modernizr.localstorage
      storageResponse = localStorage.getItem "MapImage"
      storageResponseTime = localStorage.getItem "MapImageTime"

      if storageResponse and storageResponseTime
        timeDifference = new Date().getTime() - storageResponseTime

        if timeDifference < 604800000
          forceSerer = false
          @renderMap storageResponse

   
    if forceServer
      @convertImgToBase64URL url, (dataURL) ->
        if Modernizr.localstorage
          localStorage.setItem "MapImage", dataURL
          localStorage.setItem "MapImageTime", new Date().getTime()

        @renderMap dataURL
