class CatsController < ApplicationController

  before_action :require_logged_in
  before_action :require_correct_owner

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id

    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex, :user_id)
  end

  def require_correct_owner

    return nil if params[:id].nil?
    @cat = Cat.find(params[:id])
    return nil if @cat.nil?
    if current_user != @cat.owner &&
    !["index","show","approve","deny"].include?(params[:action])
      flash[:errors] = ["YOU ARE NOT THE OWNER!"]
      redirect_to cat_url
    end

  end

end
