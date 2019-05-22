class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    # if the Message is valid then we redirect to new_message_path,
    # otherwise we stay inside the 'create' action and render the HTML form again.
    @message = Message.new(message_params)
    # call the Mailer if the message received from the user is valid
    if @message.valid?
      MessageMailer.contact_me(@message).deliver_now
      flash[:notice] = "Message has been sent."
      redirect_to new_message_path
    else
      flash[:alert] = "Please correct the errors below."
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :body)
  end

end
