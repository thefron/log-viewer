define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/log'
], ($, _, Backbone, LogView) ->
  class LogsView extends Backbone.View
    initialize: ->
      @collection.on 'add', @addOne, @
      @collection.on 'reset', @addAll, @
      @views = []

    addAll: (logs) ->
      logs.each @addOne, @

    addOne: (log) ->
      view = new LogView model: log
      view.render()

      idx = @collection.indexOf(log)
      elements = @$('li')

      if elements.length > idx
        $(elements[idx]).before(view.el)
      else
        @$el.append view.el

      rest = @views.splice(idx)
      @views = @views.concat(view).concat(rest)

      view
