class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account registered!"
      # SendConversationsSummaryEmailJob.set(wait: 24.hours).perform_later(current_user)
      redirect_to conversations_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :current_password)
  end
end
