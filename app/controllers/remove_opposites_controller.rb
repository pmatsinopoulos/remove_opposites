class RemoveOppositesController < ApplicationController
  def new
    @remove_opposite = RemoveOpposite.new
  end

  def create
    @remove_opposite = RemoveOpposite.new params[:remove_opposite]
    if @remove_opposite.process
      flash[:success] = "Successfully parsed your data. This is your result"
      render :show
    else
      flash.now[:error] = "Problem parsing your data"
      render :new, :status => 422
    end
  end
end
