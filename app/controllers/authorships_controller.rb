class AuthorshipsController < ApplicationController

  def index
    @authorships = Authorship.paginate(page: params[:page])

  end


end