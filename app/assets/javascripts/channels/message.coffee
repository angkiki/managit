App.message = App.cable.subscriptions.create "MessageChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    if $('#notice-board').children().length > 4
      $('#notice-board').children().last().remove();
      
    $('#notice-board').prepend( data.message );
    $('#notice-board-message').val('');
