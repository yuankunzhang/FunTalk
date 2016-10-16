class TopicsController < ApplicationController
  def new
    @topic = Topic.new
    render :new
  end

  def create
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      @topics = Topic.all
      render 'show'
    else
      render 'new'
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
