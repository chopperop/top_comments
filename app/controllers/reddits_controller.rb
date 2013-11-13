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
    
    @redditRecord = Reddit.cached_find(params[:id])
    @subRand = @redditRecord.subreddit
    @redditID = @redditRecord.id
    @pageTitle = @title = @redditRecord.title
    @redditTitle = @title.parameterize
    @numComments = @redditRecord.numComments
    @url = @redditRecord.url
    @externalLink = @redditRecord.externalLink
    @author = @redditRecord.author
    @comment = @redditRecord.comment
    @points = @redditRecord.points
    @time = @redditRecord.time
  end

  def destroy
  end

  def reddit_params
    params.require(:reddit).permit(:subreddit)
  end
end
