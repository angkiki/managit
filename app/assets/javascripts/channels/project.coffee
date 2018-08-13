App.project = App.cable.subscriptions.create "ProjectChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel)
    console.log("f.id: ",data.feature_id)
    $('#uncompleted-feat-' + data.feature_id).remove()
    $('.completed-features-ul').append( data.feature )
