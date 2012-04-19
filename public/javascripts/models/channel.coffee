define [
  'backbone',
], (Backbone) ->
  class Channel extends Backbone.Model
    initialize: (args, options) ->
      @set('color', "hsl(#{Math.floor(360*Math.random())},100%,35%)")
      super(args, options)
