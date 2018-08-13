App.project = App.cable.subscriptions.create "ProjectChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    if data.type == 'completed'
      $('#uncompleted-feat-' + data.feature_id).remove()
      $('.completed-features-ul').append( data.feature )
    else
      username = $('.bug-features-ul').attr('class').split(' ')[2].split('-')[1]

      if data.type == 'bugs'
        $('.bug-features-ul').append(data.feature)
        if data.username != username
          $('#close-feature-form-' + data.feature_id).remove()

      else
        $('.pending-features-ul').append(data.feature)
        if data.username != username
          $('#close-feature-form-' + data.feature_id).remove()
