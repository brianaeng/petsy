class HomepagesController < ApplicationController
  def index
    get_current_user
  end

  def show
  end

  private
  def get_current_user # Private Helper method
    @user = User.find_by(id: session[:user_id]) # It will figure out the integer thing and return nil if it doesn't find anything
  end

end
