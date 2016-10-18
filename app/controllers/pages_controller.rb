class PagesController < ApplicationController
  def home
    @topics = Topic.all.reverse
  end
end
