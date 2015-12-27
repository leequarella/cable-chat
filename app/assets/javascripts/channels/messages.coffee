App.messages = App.cable.subscriptions.create "MessagesChannel",
  received: (data) ->
    $("#inbound").append @renderMessage(data)
    objDiv = document.getElementById("inbound")
    objDiv.scrollTop = objDiv.scrollHeight

  renderMessage: (data) ->
    "<p><b>[#{data.username}]:</b> #{data.message}</p>"
