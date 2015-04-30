class ImagesController < ApplicationController

  def show
    @image = Image.find(params[:id])
  end

  def destroy
    session[:return_to] ||= request.referer
    Image.find(params[:id]).destroy
    redirect_to session.delete(:return_to)
  end

  def new
     @image = Image.new
  end

  def create
    @zine = Zine.find(params[:image][:id])
    @image = @zine.images.create(image_params)
    if @image.save
      flash[:success] = "New Image created!"
      redirect_to zine_path(@zine)
    else
      flash[:sdanger] = "Error!"
      redirect_to zine_path(@zine)
    end
  end

  private

    def image_params
      params.require(:image).permit(:caption, :cover, :width, :display_caption, :border_color, :image_file)
    end
end
