define [
  'jquery'
  'underscore'
  'backbone'
  'cs!router'
  'cs!collections/logs'
  'cs!views/logs'
  'cs!collections/channels'
  'cs!views/channels'
  'cs!collections/users'
], ($, _, Backbone, Router, Logs, LogsView, Channels, ChannelsView, Users) ->

  Backbone.couch_connector.config.db_name = 'hubot-storage'
  Backbone.couch_connector.config.ddoc_name = 'list'
  class App extends Backbone.View
    initialize: ->
      @channels = new Channels
      @channelsView = new ChannelsView
        collection: @channels
        el: @$('#channels')
      @users = new Users

      @router = new Router app: @
      Backbone.history.start()

      @_scrollEvent = (e) => @onScroll(e)
      $(window).on "scroll", @_scrollEvent

    onScroll: (e) ->
      if @currentLogs
        scrollTop = $(window).scrollTop()
        scrollBottom = $(document).height() - scrollTop - $(window).height()

        if not @currentLogs.isFetching and not @currentLogs.reachBottom and scrollBottom < 300
          @currentLogs.fetch()
