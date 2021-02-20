class PagesController < ApplicationController
  def index
    @user = current_user
    redirect_to conversations_path if current_user
  end
end
