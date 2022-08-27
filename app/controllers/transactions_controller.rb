class TransactionsController < ApplicationController
    before_action :authenticate_user!
    def index
        @transactions = Transaction.all
    end

    def create
        @transaction = Transaction.create(transaction_params)

        if @transaction.save
            redirect_to transactions_path
        else
            render :new
        end
    end

    def new
        @transaction = Transaction.new
    end

    def delete
        @transaction = Transaction.find(params[:id])
        @transaction.destroy
        redirect_to transactions_path
    end

    private

    def transaction_params
        params.require(:transaction).permit(:stock_symbol, :price, :lot_size, :transaction_type)
    end
end
