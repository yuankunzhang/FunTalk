class VotesController < ApplicationController

  def create
    if current_user.vote_count <= 0
      render :json => {:s => false}
    else
      @vote = Vote.new(:user => current_user, :topic => Topic.find(params[:topic_id]), :count => 1)
      @vote.save

      if @vote.save
        current_user.update(:vote_count => current_user.vote_count - 1)
        render :json => {:s => true, :q => {:points => current_user.vote_count, :votes => current_user.votes}}
      else
        render :json => {:s => false}
      end
    end
  end

  def destroy
    @vote = Vote.find_by(:user => current_user, :topic => Topic.find(params[:topic_id]))
    @vote.destroy
    current_user.update(:vote_count => current_user.vote_count + 1)

    render :json => {:s => true, :q => {:points => current_user.vote_count, :votes => current_user.votes}}
  end
end
