class ImagesController < ApplicationController

  def show
    @image = Image.find(params[:id])
  end

  def destroy
    session[:return_to] ||= request.referer
    Image.find(params[:id]).destroy
    flash[:success] = "Image has been deleted."
    redirect_to session.delete(:return_to)
  end

  def new
     @image = Image.new
  end

  def create
    @zine = Zine.find(params[:image][:id])
    image = Image.create(image_params)

    if image.save
      flash[:success] = "New Image created!"
      redirect_to zine_path(@zine)
    else
      flash[:danger] = "Image didn't save"
      redirect_to zine_path(@zine)
    end
  end

  def update
    session[:return_to] ||= request.referer
    image = Image.find(params[:id])
    if image.update_attributes(image_params)
      flash[:success] = "Image updated"
    else
      flash[:danger] = "Image not updated :("
    end
    redirect_to session.delete(:return_to)
  end

  private

    def image_params
      params.require(:image).permit(:caption, :width, :display_caption, :image_file, :paragraph_id, zine_content_attributes: [ :border_color, :position, :zine_id ])
    end
end
