class TopicsController < ApplicationController

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      render :json => {:s => true}
    else
      render :json => {:s => false}
    end
  end

  def update
  end

  def get_pending
    @topics = Topic.where(done: false).order(created_at: :desc)
    render :json => {:s => true, :q => {:topics => @topics}}
  end

  def get_archived
    @topics = Topic.where(done: true).order(created_at: :desc)
    render :json => {:s => true, :q => {:topics => @topics}}
  end

  private

  def topic_params
    params.require(:topic).permit(:subject, :description, :created_at)
  end
end
