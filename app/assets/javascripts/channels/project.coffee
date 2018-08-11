App.project = App.cable.subscriptions.create "ProjectChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    # alert data.content
    console.log data.feature
    # unless data.feature.blank?
    $('#close-feature-form-' + data.feature.id).remove()
    $('.completed-features-ul').append( $('#uncompleted-feat-' + data.feature.id) )
