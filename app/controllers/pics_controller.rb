class PicsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @pics = Pic.all
  end

  def new
    @pic = Pic.new
  end

  def create
    @pic = current_user.pics.create(pic_params) 
    if @pic.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end  
  end

  def show
    @pic = Pic.find(params[:id])
  end

  private

  def pic_params
    params.require(:pic).permit(:message)
  end
end
