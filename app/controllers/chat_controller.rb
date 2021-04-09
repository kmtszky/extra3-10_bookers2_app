class ChatController < ApplicationController
  def show
    @user = User.find(params[:id])                    #params[:id] => チャット相手show pageのid
  end
end
