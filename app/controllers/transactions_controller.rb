class TransactionsController < ApplicationController
    before_action :authenticate_user!
    before_action :get_user
    def index
        if @user.role == 'trader'
            @transactions = @user.transactions
        elsif @user.admin?
            redirect_to admin_path
        else
            raise ActionController::RoutingError.new('Not Found')
        end
    end

    def create
        if @user.is_approved == 'verified'
            @transaction = @user.transactions.create(transaction_params)

            if @transaction.save
                redirect_to transactions_path, notice: "Transactions saved!"
            else
                render :new
            end
        else
            redirect_to transactions_path, alert: "Transaction Failed! You are not yet verified."
        end
    end

    def new
        @stocks = Stock.all
        @transaction = @user.transactions.new
    end

    def delete
        if @user.is_approved == 'verified'
            @transaction = @user.transactions.find(params[:id])
            @transaction.destroy
            redirect_to transactions_path, notice: "Transactions deleted!"
        else
            redirect_to transactions_path, alert: "Transaction Failed! You are not yet verified."
        end
    end

    def my_portfolio
        test1 = {}
        @sell_minus_buy = 0
        @transactions = []
        @user.transactions.each do |transaction|
            test1["stock_symbol"] = transaction.stock_symbol
            test1["price"] = transaction.price
            test1["lot_size"] = transaction.lot_size
            test1["transaction_type"] = transaction.transaction_type
            if transaction.transaction_type == 'buy'
                test1["total_price"] = (transaction.price * transaction.lot_size)*(-1)
            else
                test1["total_price"] = transaction.price * transaction.lot_size
            end
            @transactions.push(test1)
            test1 = {}
            if transaction.transaction_type == 'buy'
                @sell_minus_buy = @sell_minus_buy - (transaction.price * transaction.lot_size)
            else
                @sell_minus_buy = @sell_minus_buy + (transaction.price * transaction.lot_size)
            end
        end
    end

    private
    def get_user
        @user = User.find_by(id:current_user)
        if @user.admin?
            redirect_to dashboard_path
        elsif @user.nil?
            raise ActionController::RoutingError.new('Not Found')
        end
    end

    def transaction_params
        params.require(:transaction).permit(:stock_symbol, :price, :lot_size, :transaction_type)
    end

end


