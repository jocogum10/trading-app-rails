class AdminController < ApplicationController
  def index
    @transactions = Transaction.all
    @users = User.all
  end

  def users
    @users = User.all
  end

  def show_user
  end
end
