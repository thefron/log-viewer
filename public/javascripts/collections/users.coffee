define [
  'jquery'
  'underscore'
  'backbone'
  'cs!models/user'
], ($, _, Backbone, User) ->
  class Users extends Backbone.Collection
    model: User
