define [
  'jquery'
  'underscore'
  'backbone'
  'cs!models/log'
  'cs!collections/logs'
], ($, _, Backbone, Log, Logs) ->
  class ChannelLogs extends Logs
    initialize: (attrs, options) ->
      super(attrs, options)
      @db.keys = [@options.channel]
      @db.channel = @options.channel

    db:
      changes: no # Change to yes to track changes
      view: 'byChannel'
      filter: "list/by_channel"
