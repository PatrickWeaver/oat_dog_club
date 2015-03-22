class ZinesController < ApplicationController

def show
  @zine = Zine.find(params[:id])
end


end