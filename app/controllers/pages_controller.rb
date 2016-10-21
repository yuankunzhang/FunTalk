class PagesController < ApplicationController
  def home
    # @topics = Topic.where(done: false).order(created_at: :desc)
  end
end
