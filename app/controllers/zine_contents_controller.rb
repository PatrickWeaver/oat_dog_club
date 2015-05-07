class ZineContentsController < ApplicationController

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
      zine_content.insert_at(1)
    elsif direction == "bottom"
      zine_content.move_to_bottom
    elsif direction == "cover"
      old_cover = 
        if zine.zine_contents.where(position: 0).first
          zine.zine_contents.where(position: 0).first
        end
      zine_content.insert_at(0)
      old_cover.move_to_bottom
      old_cover.remove_from_list
    elsif direction == "remove-cover"
      zine_content.remove_from_list
      zine_content.orderable.destroy
    end



    redirect_to session.delete(:return_to)
  end

end


def font_size
  @paragraph = Paragraph.find(params[:id])
  size_change = params[:size].to_i
  size_now = @paragraph.font_size
  session[:return_to] ||= request.referer
  @paragraph = Paragraph.find(params[:id])
  if size_change < 0
    if size_now > 30
      size_now += size_change * 2.5
    elsif size_now > 6
      size_now += size_change
    end
  else
    if (30..99).include?(size_now)
      size_now += size_change *2.5
    elsif size_now < 30
      size_now += size_change
    end
  end
  @paragraph.font_size = size_now
  @paragraph.save
  redirect_to session.delete(:return_to)
end