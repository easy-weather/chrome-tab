WEATHER.Views.Loading =  Backbone.View.extend(
  initialize = ->
    @el = $(@el)
    @template = _.template(WEATHER.Templates.loading)

  render = ->
    @el.html @template()

  postRender = ->
)
