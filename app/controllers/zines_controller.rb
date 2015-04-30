class ZinesController < ApplicationController
  before_action :signed_in_user,  only: [:destroy, :publish, :create, :update]

  def create
    @user = current_user
    @zine = @user.zines.create(zine_params)
    if @zine.save
      flash[:success] = "New zine created! Now write something!"
      redirect_to zine_path(@zine)
    else
      render 'static_pages/home'
    end

  end

  def index
    @zines = Zine.paginate(page: params[:page])
  end

  def show
    @zine = Zine.find(params[:id])
    @user = current_user


    if zine_viewable?(@user)
      @paragraph = Paragraph.new
      @image = Image.new
      @authors = @zine.users.to_a
      if @zine.images.where(cover: true).any?
        @cover = @zine.images.where(cover: true).first
      end
      @paragraphs = @zine.paragraphs.paginate(page: params[:page])
      @images = @zine.images.where(:paragraph_id => nil).paginate(page: params[:page])
      def get_images_for_paragraph(paragraph)
          paragraph_images = Image.where(paragraph_id: paragraph.id).to_a
      end
      @editor =
        if user_editor?(@user)
          true
        else
          false
        end
      @font_size = @paragraph.font_size


      
    else
      redirect_to root_url
    end
  end

  def update
    @zine = Zine.find(params[:id])
    if @zine.update_attributes(zine_params)
      redirect_to @zine
    else
      flash[:danger] = "Invalid edit!"
      redirect_to @zine
    end
  end

  def publish
    session[:return_to] ||= request.referer
    @zine = Zine.find(params[:id])
    @zine.toggle!(:published)
    @zine.save
    redirect_to session.delete(:return_to)
  end

  def title
    zine = Zine.find(params[:id])
    zine.toggle!(:show_title)
    zine.save
    redirect_to zine
  end

  def authors
    zine = Zine.find(params[:id])
    zine.toggle!(:show_authors)
    zine.save
    redirect_to zine
  end

  def remove_author
    author = User.find(params[:author])
    zine = Zine.find(params[:id])
    if author
      if zine.users.to_a.length > 1
        zine.remove_author!(author)
      else
        flash[:warning] = "You can't remove the last author!"
      end
    else
      flash[:danger] = "No user with email #{params[:author]}!"
    end
    redirect_to zine
  end

  def add_author
    author = User.where(email: (params[:email])).first
    zine = Zine.find(params[:id])
    if author
      unless zine.written_by?(author)
        zine.add_author!(author)
      else
        flash[:warning] = "#{params[:email]} is already an author of this zine!"
      end
    else
      flash[:danger] = "No user with email #{params[:email]}!"
    end
    redirect_to zine
  end

  def font_size_up
    if paragraph_id
      redirect_to paragraph_path(paragraph_id)
    else
      session[:return_to] ||= request.referer
      @paragraph = Paragraph.find(params[:id])
      if @paragraph.font_size < 30
        @paragraph.font_size += 2
      else
        if @paragraph.font_size < 100
          @paragraph.font_size += 5
        end
      end
      redirect_to session.delete(:return_to)
    end
  end

  def font_size_down
    session[:return_to] ||= request.referer
    @paragraph = Paragraph.find(params[:id])
    if @paragraph.font_size > 30
      @paragraph.font_size -= 5
    else
      if @paragraph.font_size > 4
        @paragraph.font_size += 2
      end
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] ||= request.referer
    @zine = Zine.find(params[:id])
    @zine.destroy
    flash[:success] = "#{@zine.title} has been deleted."
    redirect_to session.delete(:return_to)
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
      params.require(:zine).permit(:title, :published, :user)
    end


    def user_editor?(user)
      if @user
        if @user.authoring?(@zine)
          true
        elsif @user.admin?
          true
        end
      else
        false
      end
    end


    def zine_viewable?(user)
      if @zine.published == true
        true
      elsif @user
        user_editor?(@user)
      end
    end
end