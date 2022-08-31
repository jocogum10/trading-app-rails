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
  end

  private
    def get_user
        @user = User.find_by(id:current_user)
        if @user.trader?
          @transactions = @user.transactions
          redirect_to transactions_path
        elsif @user.nil?
          raise ActionController::RoutingError.new('Not Found')
        end
    end
end
