define [
  'backbone',
  'order!lib/jquery.couch'
  'order!lib/backbone-couchdb'
], (Backbone) ->
  class User extends Backbone.Model
    idAttribute: 'id'
    initialize: (args, options) ->
      @set('color', "hsl(#{Math.floor(360*Math.random())},100%,30%)")
      super(args, options)
