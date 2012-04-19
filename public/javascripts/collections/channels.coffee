define [
  'jquery'
  'underscore'
  'backbone'
  'cs!models/channel'
], ($, _, Backbone, Channel) ->
  class Channels extends Backbone.Collection
    model: Channel
    ###
    url: '/channels'

    db:
      view: 'channels'
      changes: no

    parse: (resp) ->
      console.log resp
      _.map resp[0], (channel) -> name: channel
    ###
