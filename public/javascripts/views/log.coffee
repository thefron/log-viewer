define [
  'jquery'
  'underscore'
  'backbone'
  'mustache'
  'text!templates/log.mustache'

  'order!lib/jquery.timeago'
], ($, _, Backbone, Mustache, LogTemplate) ->
  class LogView extends Backbone.View
    tagName: 'li'
    className: 'log_entry clearfix'

    render: ->
      @$el.html Mustache.render(LogTemplate, @model.toJSON())
      @$('.channel').css('color', @model.channel.get('color'))
      @$('.user').css('color', @model.user.get('color'))
      @$('.timeago').timeago()
      @
