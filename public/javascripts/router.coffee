define [
  'jquery'
  'underscore'
  'backbone'
  'cs!collections/logs'
  'cs!collections/channel_logs'
  'cs!views/logs'
], ($, _, Backbone, Logs, ChannelLogs, LogsView) ->
  class Router extends Backbone.Router
    routes:
      '': 'all'
      'channels/:name': 'channel'

    initialize: (options) ->
      @app = options.app

    all: ->
      @onRoute()

      @app.$('#channels li').removeClass('active')
      @app.$('#channels .all').addClass('active')

      @app.logs = new Logs
      @app.currentLogs = @app.logs
      @app.logsView = new LogsView
        collection: @app.logs
        el: @app.$('#logs')
      @app.logsView.render()
      @app.logs.fetch()

    channel: (name) ->
      @onRoute()

      channel_name = "##{name}"
      channel = @app.channels.find((channel) -> channel.get('name') is channel_name) or @app.channels.add(name: channel_name)

      @app.$('#channels li').removeClass('active')
      @app.channelsView.getViewByName(channel_name).$el.addClass('active')

      @app.logs = new ChannelLogs [], channel: channel_name
      @app.currentLogs = @app.logs
      @app.logsView = new LogsView
        collection: @app.logs
        el: @app.$('#logs')
      @app.logsView.render()
      @app.logs.fetch()

    onRoute: ->
      @app.$('#logs').empty()
      @app.currentLogs?.uninitialize()
      @app.currentLogs = undefined
