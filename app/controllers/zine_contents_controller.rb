class ZineContentsController < ApplicationController
  before_action :signed_in_user, only:[:position, :hide_border_color, :update]

  def index
    @zine_contents = ZineContent.paginate(page: params[:page])
  end

  def position
    session[:return_to] ||= request.referer
    zine_content = ZineContent.find(params[:id])
    zine = zine_content.zine
    direction = params[:direction]
    if direction == "up"
      zine_content.move_higher
    elsif direction == "down"
      zine_content.move_lower
    elsif direction == "top"
      zine_content.move_to_top
    elsif direction == "bottom"
      zine_content.move_to_bottom
    end



    redirect_to session.delete(:return_to)
  end

  def hide_border_color
    session[:return_to] ||= request.referer
    zine_content = ZineContent.find(params[:id])
    zine_content.border_color = "None"
    if zine_content.save
      flash[:success] = "Border hidden!"
    else
      flash[:danger] = "Border not hidden :("
    end
    redirect_to session.delete(:return_to)

  end

  def update
    session[:return_to] ||= request.referer
    zine_content = ZineContent.find(params[:id])
    if zine_content.update_attributes(zine_content_params)
      flash[:success] = "Image updated!"
    else
      flash[:danger] = "Image not updated :("
    end
    redirect_to session.delete(:return_to)
  end

  private

      def zine_content_params
      params.require(:zine_content).permit(:border_color, :position)
    end

end