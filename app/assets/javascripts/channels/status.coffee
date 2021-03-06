jQuery(document).on 'turbolinks:load', ->
  App.status = App.cable.subscriptions.create "StatusChannel",
    connected: ->
      console.log('StatusChannel connected')

    disconnected: ->
      console.log('StatusChannel disconnected')
   
    received: (data) ->
      console.log('StatusChannel received')
   
      App.status.drawOnlineUsers(data.users);
   
    drawOnlineUsers: (users) ->
      if (users.length > 0)
        text = 'Online: '
        text += users.map((user) -> user.nickname).join(', ')
   
        $('.js-online-users').text(text)
