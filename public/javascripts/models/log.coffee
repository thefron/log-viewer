define [
  'backbone'
  'cs!models/channel'
  'cs!models/user'
  'order!lib/jquery.couch'
  'order!lib/backbone-couchdb'
], (Backbone, Channel, User) ->
  class Log extends Backbone.Model
    initialize: (args) ->
      super(args)

      if channel = window.app.channels.find((channel) => channel.get('name') is @get('user').room)
        @channel = channel
      else
        @channel = new Channel(name: @get('user').room)
        window.app.channels.add(@channel)

      if user = window.app.users.find((user) => user.id is @get('user').id)
        @user = user
      else
        @user = new User
          id: @get('user').id
          name: @get('user').name
        window.app.users.add(@user)
