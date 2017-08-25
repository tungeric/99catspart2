class UsersController < ApplicationController
  before_action :go_to_index_if_signed_in

  def new
    render :new
  end

  def create
    debugger
    @user = User.new(user_params)
    if(@user.save)
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end

  end

  def show
    @sess = session[:session_token]
    @user  = User.find_by(id: params[:id])
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end


end
