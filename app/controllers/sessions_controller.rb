class SessionsController < ApplicationController
before_action :go_to_index_if_signed_in

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:user_name], user_params[:password])
    if @user.nil?
      flash[:errors] = ["Invalid username or password!"]
      redirect_to new_session_url
    else
      @user.reset_session_token!
      login!(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    @user = current_user
    if @user
      logout!
    else
      flash.now[:errors] = ["Invalid username or password!"]
    end
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
