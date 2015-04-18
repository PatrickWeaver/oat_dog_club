class ZinesController < ApplicationController
  before_action :signed_in_user,  only: :destroy


  def show
    @zine = Zine.find(params[:id])
    @user = current_user

    def zine_viewable?
      if @zine.published == true
        true
      elsif @user
        if @user.authoring?(@zine)
          true
        elsif @user.admin?
          true
        end
      else
        false
      end
    end


    if zine_viewable?
        @paragraphs = @zine.paragraphs.paginate(page: params[:page])
        @images = @zine.images.where(:paragraph_id => nil).paginate(page: params[:page])
        def get_images_for_paragraph(paragraph)
          paragraph_images = Image.where(paragraph_id: paragraph.id).to_a
        end
      
    else
      redirect_to root_url
    end
  end

  def publish
    @zine = Zine.find(params[:id])
    @zine.toggle!(:published)
    @zine.save
    redirect_to user_path(current_user)
  end

  def destroy
    Zine.find(params[:id]).destroy
    flash[:success] = "Zine has been deleted."
    redirect_to user_path(current_user)
  end



  def is_author?
    @zine = current_user.zines.find_by(id: params[:id])
    unless @zine.nil?
    end
  end

  def admin_user?
    redirect_to(root_url) unless current_user.admin?
  end

  private

    def zine_params
      params.require(:zine).permit(:title, :published)
    end

end