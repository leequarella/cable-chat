App.users = App.cable.subscriptions.create "UsersChannel",
  connected: ->
    console.log "Connected to messages"

  received: (data) ->
    $("#inbound").append @renderMessage(data)
    objDiv = document.getElementById("inbound")
    objDiv.scrollTop = objDiv.scrollHeight

  renderMessage: (data) ->
    "<div class='inbound-message'>
      <div class='chat-timestamp'>
        #{strftime("%H:%M%P")}
      </div>
      <p>
        <b>[#{data.username}]:</b>
        #{data.message}
      </p>
    </div>
    "
