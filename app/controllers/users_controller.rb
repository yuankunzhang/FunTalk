class UsersController < ApplicationController

  def get_info
    render :json => {:s => true, :q => {:points => current_user.vote_count, :votes => current_user.votes}}
  end

end
