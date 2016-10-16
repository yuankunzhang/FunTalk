class TopicsController < ApplicationController
  def new
    @topic = Topic.new
    render :show_form
  end
end
