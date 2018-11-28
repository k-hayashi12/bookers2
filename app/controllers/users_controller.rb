class UsersController < ApplicationController

before_action :authenticate_user!

  before_action :ensure_correct_user, {only: [:edit, :update]}

  def ensure_correct_user
    if params[:id].to_i != current_user.id
        redirect_to user_path(current_user.id)
    end
  end

  def show
  	@user = User.find(params[:id])
  	@book_show = Book.new

  end

  def edit
    @user = User.find(params[:id])
  end

  def index
  	@user = User.find(current_user.id)
  	@book_show = Book.new
  	@users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id)
  else
    render :edit
  end
  end

private
def user_params
  params.require(:user).permit(:name, :image, :introduction, :email)
end


end
