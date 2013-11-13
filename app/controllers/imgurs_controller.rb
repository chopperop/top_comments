class ImgursController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
    @clicks = Comment.cache_first
    
    @imgurRecord = Imgur.cached_find(params[:id])
    @imgurID = @imgurRecord.id
    @pageTitle = @Ititle = @imgurRecord.title
    @imgurTitle = @Ititle.parameterize
    @Iid = @imgurRecord.imgurID
    @InumComments = @imgurRecord.numComments
    @IpictureLink = @imgurRecord.pictureLink
    @Iauthor = @imgurRecord.author
    @Icomment = @imgurRecord.comment
    @Ipoints = @imgurRecord.points
    @Itime = @imgurRecord.time
  end

  def destroy
  end

  def imgur_params
  end
end
