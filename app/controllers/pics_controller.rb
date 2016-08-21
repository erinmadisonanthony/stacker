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
    @pic = Pic.find_by_id(params[:id])
    return render_not_found if @pic.blank?
  end

  def edit
    @pic = Pic.find_by_id(params[:id])
    return render_not_found if @pic.blank?
  end

  def update
    @pic = Pic.find_by_id(params[:id])
    return render_not_found if @pic.blank?

    @pic.update_attributes(pic_params)

    if @pic.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  private

  def pic_params
    params.require(:pic).permit(:message)
  end

  def render_not_found
    render text: 'Not Found', status: :not_found 
  end
end
