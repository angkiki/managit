class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)

    if @message.save
      ActionCable.server.broadcast('message_channel', message: render_message(@message))
    end
  end

  private
  def message_params
    params.require(:message).permit(:message, :user_id, :project_id)
  end

  def render_message(message)
    render(partial: 'messages/message', locals: { m: message } )
  end
end
