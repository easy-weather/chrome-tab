WEATHER.Views.Conditions = Backbone.View.extend(
  id: "conditions"

  initialize: ->
    @el = $(@el)
    @template = _.template(WEATHER.Templates.conditions)

  render: ->
    conditions = @model.models[0].toJSON()
    $(@el).html @template(conditions)
    this
)
