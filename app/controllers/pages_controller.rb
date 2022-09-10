class PagesController < ApplicationController
  before_action :get_user
  def home
    @stocks = Stock.all
  end

  def about
  end

  private
    def get_user
        @user = User.find_by(id:current_user)
    end
end
