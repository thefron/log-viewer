define [
  'jquery'
  'underscore'
  'backbone'
  'mustache'
  'text!templates/channel.mustache'

  'order!lib/jquery.timeago'
], ($, _, Backbone, Mustache, ChannelTemplate) ->
  class ChannelView extends Backbone.View
    tagName: 'li'
    className: 'channel_entry'
    events:
      'click .name': 'filterChannel'

    render: ->
      @$el.html Mustache.render(ChannelTemplate, @model.toJSON())
      @$('.name').css('color', @model.get('color'))
      @

    filterChannel: (e) ->
      e.preventDefault()
      window.app.router.navigate("channels/#{@model.get('name').substr(1)}", trigger: yes)
