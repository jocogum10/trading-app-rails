class TransactionsController < ApplicationController
    before_action :authenticate_user!
    before_action :get_user, except: [:delete]
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
        @transaction = Transaction.find(params[:id])
        @transaction.destroy
        redirect_to transactions_path, notice: "Transactions deleted!"
    end

    def my_portfolio
        transaction_by_stock_symbol = {
        }
        # the stocks portfolio
        @transactions = []
        @user.transactions.each do |transaction|
            if transaction_by_stock_symbol.key?(transaction.stock_symbol)
                transaction_by_stock_symbol[transaction.stock_symbol].push(transaction)
            else
                transaction_by_stock_symbol[transaction.stock_symbol] = [transaction]
            end
        end
        @total_stock_price = 0
        transaction_by_stock_symbol.each do |stock_symbol, transactions|
            total_buy_lot = 0
            total_sell_lot = 0
            
            total_buy_price = 0
            total_sell_price = 0
            transactions.each do |transaction|
                puts transaction.transaction_type
                if transaction.transaction_type == 'buy'
                    total_buy_lot = total_buy_lot + transaction.lot_size
                    total_buy_price = total_buy_price + (transaction.lot_size*transaction.price)
                else
                    total_sell_lot = total_sell_lot + transaction.lot_size
                    total_sell_price = total_sell_price + (transaction.lot_size*transaction.price)
                end
            end
            puts total_buy_lot
            puts total_sell_lot
            if total_buy_lot > total_sell_lot
                @transactions.push({stock_symbol: stock_symbol, lot_size: total_buy_lot-total_sell_lot, total_price: total_buy_price-total_sell_price})
            end
        end
        @transactions.each do |stock|
            @total_stock_price = @total_stock_price + stock[:total_price]
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


