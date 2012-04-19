define [
  'jquery'
  'underscore'
  'backbone'
  'cs!models/log'
  'cs!collections/logs'
  'order!lib/jquery.couch'
  'order!lib/backbone-couchdb'
], ($, _, Backbone, Log, Logs) ->
  class ChannelLogs extends Logs
    initialize: (attrs, options) ->
      super(attrs, options)
      @db.keys = [@options.channel]
      @db.channel = @options.channel

    db:
      changes: yes
      view: 'byChannel'
      filter: "list/by_channel"