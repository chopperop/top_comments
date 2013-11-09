class ImgursController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
    @clicks = Comment.cache_first
    
    @imgur = Imgur.cached_find(params[:id])
    @Ititle = @imgur.title
    @Iid = @imgur.imgurID
    @InumComments = @imgur.numComments
    @IpictureLink = @imgur.pictureLink
    @Iauthor = @imgur.author
    @Icomment = @imgur.comment
    @Ipoints = @imgur.points
    @Itime = @imgur.time
  end

  def destroy
  end

  def imgur_params
  end
end
