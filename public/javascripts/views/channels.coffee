define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/channel'
], ($, _, Backbone, ChannelView) ->
  class ChannelsView extends Backbone.View
    initialize: ->
      @collection.on 'add', @addOne, @
      @collection.on 'reset', @addAll, @
      @views = []

    addAll: (channels) ->
      channels.each @addOne, @

    addOne: (channel) ->
      view = new ChannelView model: channel
      @$el.append(view.render().el)
      @views.push view

      view

    getModelView: ( id ) ->
      _.find @views, ( view ) ->
        view.model.id == id

    getViewByName: (name) ->
      _.find @views, ( view ) ->
        view.model.get('name') is name
