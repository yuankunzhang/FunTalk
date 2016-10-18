class TopicsController < ApplicationController
  def new
    @topic = Topic.new
    render 'new'
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      render :json => {:status => 'ok'}
    else
      render :json => {:status => 'err'}
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def topic_params
    params.require(:topic).permit(:subject, :description, :created_at)
  end
end
