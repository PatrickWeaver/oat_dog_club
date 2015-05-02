class ZineContentsController < ApplicationController

  def index
    @zine_contents = ZineContent.paginate(page: params[:page])
  end

end
