class StaticPagesController < ApplicationController
  def home
    if :signed_in_user
      @signed_in = true
    else
      @signed_in = false
    end
  end

  def help
  end

  def about
  end
  
  def contact
  end
  
end
