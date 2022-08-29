class TransactionsController < ApplicationController
    before_action :authenticate_user!
    before_action :get_user
    def index
        puts @user.role
        if @user.role == 'admin'
            @transactions = Transaction.all
        else
            @transactions = @user.transactions
        end
    end

    def create
        @transaction = @user.transactions.create(transaction_params)

        if @transaction.save
            redirect_to transactions_path
        else
            render :new
        end
    end

    def new
        @transaction = @user.transactions.new
    end

    def delete
        @transaction = @user.transactions.find(params[:id])
        @transaction.destroy
        redirect_to transactions_path
    end

    private
    def get_user
        @user = User.find_by(id:current_user)
    end

    def transaction_params
        params.require(:transaction).permit(:stock_symbol, :price, :lot_size, :transaction_type)
    end
end
