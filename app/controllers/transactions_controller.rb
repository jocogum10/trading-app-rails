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
        client = IEX::Api::Client.new(
            publishable_token: 'pk_357b98eff382413285d895c98242c6a8',
            secret_token: 'sk_4fa4a6ff12c64c97839dca46df3b5406',
            endpoint: 'https://cloud.iexapis.com/v1'
        )
        @top_stocks = client.stock_market_list(:mostactive)
        # @stocks = top_stocks.map{|x| x["symbol"]}
        # @prices = top_stocks.map{|x| x["latest_price"]}
        # top_stocks.each do |x|
        #     puts x["symbol"]
        #     puts x["latest_price"]
        # end
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


