class ImagesController < ApplicationController

def show
  @image = Image.find(params[:id])
end

def destroy
  session[:return_to] ||= request.referer
  Image.find(params[:id]).destroy
  redirect_to session.delete(:return_to)
end


end