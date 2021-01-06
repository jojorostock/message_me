class ChatroomController < ApplicationController
  
  before_action :require_user
  

  def index
    @message = Message.new()
    @friend = 0
    @messages = Message.custom_display
  end

end