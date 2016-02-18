class CoversController < ApplicationController
  before_action :signed_in_user

  def remove
    session[:return_to] ||= request.referer
    cover = Cover.find(params[:id])
    cover.destroy
    flash[:success] = "Cover has been removed."
    redirect_to session.delete(:return_to)
  end

  def cover
    session[:return_to] ||= request.referer
    new_cover = Image.find(params[:id])
    if new_cover.zine_content
      zine = new_cover.zine_content.zine
      border_color = new_cover.zine_content.border_color
    else
      zine = new_cover.paragraph.zine_content.zine
      border_color = nil
    end
    if zine.cover
      old_cover = zine.cover
      old_cover.destroy
    end
    cover = zine.create_cover(width: new_cover.width, border_color: border_color, cover_image: URI.parse(new_cover.image_file.url) )
    

    flash[:success] = "Cover has been changed"
    redirect_to session.delete(:return_to)
  end

  def update
    session[:return_to] ||= request.referer
    cover = Cover.find(params[:id])
    if cover.update_attributes(cover_params)
      flash[:success] = "Cover updated"
    else
      flash[:danger] = "Cover not updated :("
    end
    redirect_to session.delete(:return_to)
  end

  def create
    @zine = Zine.find(params[:cover][:id])
    cover = @zine.create_cover(cover_params)

    if cover.save
      flash[:success] = "New Cover created!"
      redirect_to zine_path(@zine)
    else
      flash[:danger] = "Cover didn't save"
      redirect_to zine_path(@zine)
    end
  end

  private

    def cover_params
      params.require(:cover).permit(:width, :border_color, :cover_image)
    end
end