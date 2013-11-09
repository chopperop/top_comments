class RedditsController < ApplicationController
  def index
  end

  def new
  end

  def create
    Reddit.create(reddit_params)
  end

  def show
    @clicks = Comment.cache_first
    
    @reddit = Reddit.cached_find(params[:id])
    @subRand = @reddit.subreddit
    @redditID = @reddit.id
    @title = @reddit.title
    @numComments = @reddit.numComments
    @url = @reddit.url
    @externalLink = @reddit.externalLink
    @author = @reddit.author
    @comment = @reddit.comment
    @points = @reddit.points
    @time = @reddit.time
  end

  def destroy
  end

  def reddit_params
    params.require(:reddit).permit(:subreddit)
  end
end
