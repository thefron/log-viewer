define [
  'jquery'
  'underscore'
  'backbone'
  'cs!models/log'
  'order!lib/jquery.couch'
  'order!lib/backbone-couchdb'
], ($, _, Backbone, Log) ->
  class Logs extends Backbone.Collection
    model: Log
    url: '/logs'
    db:
      changes: yes
      view: 'byCollection'

    initialize: (attrs, options) ->
      @options = options || {}

      super(attrs, options)

    comparator: (log) ->
      date = new Date(log.get('date'))
      -date.getTime()

    fetch: (opts = {}) ->
      opts.add ||= yes
      opts.limit ||= 200
      opts.descending ||= yes
      if @length > 0
        opts.startkey ||= 'logs' unless @db.keys
        opts.startkey_docid ||= @last().id
        opts.skip ||= 1

      @isFetching = yes
      @prevLength = @length

      _opts = _.clone opts
      _opts.success = (logs) =>
        @reachBottom = yes if logs.length is @prevLength
        opts.success?(logs)

      _opts.complete = () =>
        @isFetching = no
        opts.complete?()

      super(_opts)

    uninitialize: ->
      @stop_changes()
