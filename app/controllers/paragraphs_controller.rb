class ParagraphsController < ApplicationController
  before_action :signed_in_user, only:[:new, :create, :destroy]

  def show
    @paragraph = Paragraph.find(params[:id])

    @images = @paragraph.images.paginate(page: params[:page])
  end

  def new
    @paragraph = Paragraph.new

  end

  def create
    @zine = Zine.find(params[:paragraph][:id])
    paragraph = Paragraph.create(paragraph_params)

    if paragraph.save
      flash[:success] = "New paragraph created!"
      redirect_to zine_path(@zine)
    else
      render 'static_pages/home'
    end

  end

  def destroy
    session[:return_to] ||= request.referer
    paragraph = Paragraph.find(params[:id])
    paragraph.destroy
    flash[:success] = "#{paragraph.header} has been deleted."
    redirect_to session.delete(:return_to)
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


  private


      def paragraph_params
        params.require(:paragraph).permit(:header, :content, zine_content_attributes: [ :border_color, :order, :zine_id ])
      end


end


  