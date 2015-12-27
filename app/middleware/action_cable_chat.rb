# middleware/action_cable_chat.rb

class ActionCableChat
  def initialize(app, options={})
    @app = app
    ActionCable.server.config.allowed_request_origins = ["http://world-oyster.herokuapp.com"]
  end

  def call(env)
    begin
      if Faye::WebSocket.websocket?(env)
        ActionCable.server.call(env)
      else
        @app.call(env)
      end
    rescue Exception => ex
      puts 'MIDDLEWARE EXCEPTION:'
      puts ex
      puts ex.backtrace
      puts "----------"
    end
  end
end
