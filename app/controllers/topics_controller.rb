require 'github/markdown'

class TopicsController < ApplicationController

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user

    if @topic.save
      render :json => {:s => true}
    else
      render :json => {:s => false}
    end
  end

  def update
  end

  def show
    @topic = Topic.find(params[:id])
    @topic.content = GitHub::Markdown.render_gfm(@topic.content)
  end

  def get_pending
    @topics = Topic.left_outer_joins(:user, :votes).select('topics.*,users.first_name as author,count(votes.count) as vote_count').where(completed: false).group('topics.id').order("vote_count DESC")
    render :json => {:s => true, :q => {:topics => @topics}}
  end

  def get_archived
    @topics = Topic.left_outer_joins(:user).select('topics.*,users.first_name as author').where(completed: true).order(created_at: :desc)
    render :json => {:s => true, :q => {:topics => @topics}}
  end

  private

  def topic_params
    params.require(:topic).permit(:subject, :description, :created_at)
  end
end
