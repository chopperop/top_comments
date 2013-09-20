class RedditsController < ApplicationController
  def index
  end

  def new
  end

  def create
    Reddit.create(reddit_params)
  end

  def show
  end

  def destroy
  end

  def reddit_params
    params.require(:reddit).permit(:subreddit)
  end
end
