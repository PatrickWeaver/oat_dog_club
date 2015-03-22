class ZinesController < ApplicationController

def show
  @zine = Zine.find(params[:id])
  @paragraphs = @zine.paragraphs.paginate(page: params[:page])
end


end