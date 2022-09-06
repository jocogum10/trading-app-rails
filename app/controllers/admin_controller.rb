class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
    @transactions = Transaction.all
    @users = User.all.order(is_approved: :asc, confirmed_at: :asc)
  end

  def send_welcome_email
    @user = User.find(params[:id])
    AdminMailer.with(user: @user).welcome_email.deliver_later
    redirect_to dashboard_path, notice: 'User was successfully created.'
  end

  def show_user
    @user = User.find(params[:id])
  end

  def new_user
    @user = User.new
  end
  
  def create_user
    @user = User.create(user_create_params)

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
      redirect_to dashboard_path, notice: "User verified!"
    else
      redirect_to dashboard_path, alert: "User is not yet confirmed, see email sent."
    end
  end

  def edit_user
    @user = User.find(params[:id])
  end

  def update_user
    @user = User.find(params[:id])
    @user.update(role: params[:user][:role], is_approved: params[:user][:is_approved])
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

  def user_create_params
    params.require(:user).permit(:email, :role, :password, :password_confirmation)
  end
end
