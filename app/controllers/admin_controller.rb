class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
      @transactions = Transaction.all
      @users = User.all.order(is_approved: :asc, confirmed_at: :asc)
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

  def approve_user
    @user = User.find(params[:id])

    if @user.confirmed_at.present?
      @user.is_approved = 1
      @user.save
      redirect_to dashboard_path, notice: "User verified"
    else
      redirect_to dashboard_path, notice: "User is not yet confirmed"
    end
  end

  def edit_user
    @user = User.find(params[:id])
  end

  def update_user
    @user = User.find(params[:id])
    @user.update(email: params[:user][:email], role: params[:user][:role], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
    redirect_to dashboard_path
  end

  private
  def get_user
      if User.find_by(id:current_user).role == 'trader'
        redirect_to transactions_path
      elsif User.find_by(id:current_user).nil?
        raise ActionController::RoutingError.new('Not Found')
      end
  end

  def user_params
    params.require(:user).permit(:email, :role, :password, :password_confirmation)
  end
end
