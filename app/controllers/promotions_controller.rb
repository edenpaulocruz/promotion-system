class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
  end

  def show
    id = params[:id]
    @promotion = Promotion.find(id)
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to @promotion
    else
      render :new
    end
  end

  private

  def promotion_params
    params.require(:promotion).permit(:name, :description, :code,
                                      :discount_rate, :coupon_quantity,
                                      :expiration_date)
  end
end