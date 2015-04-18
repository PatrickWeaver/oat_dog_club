class ParagraphsController < ApplicationController

def show
  @paragraph = Paragraph.find(params[:id])

  @images = @paragraph.images.paginate(page: params[:page])
end


end


  