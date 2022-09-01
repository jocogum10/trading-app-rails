class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
      @transactions = Transaction.all
      @users = User.all
  end

  def show_user
    @user = User.find(params[:id])
  end

  def new_user
    @user = User.new
  end
  
  def create_user
    @user = User.create(user_params)

    if @user.save
        redirect_to dashboard_path
    else
        render :new
    end
  end

  private
  def get_user
      if User.find_by(id:current_user).trader?
        redirect_to transactions_path
      elsif User.find_by(id:current_user).nil?
        raise ActionController::RoutingError.new('Not Found')
      end
  end

  def user_params
    params.require(:user).permit(:email, :role, :password, :password_confirmation)
  end
end
