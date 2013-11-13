module ApplicationHelper
  def markdown(text)
    options = [:hard_wrap => true, :filter_html => true, :autolink => true, :no_intra_emphasis => true, :fenced_code_blocks => true, :disable_indented_code_blocks => true, :quote => true, :gh_blockcode => true]
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, *options)
    markdown.render(text).html_safe     
  end
  
  def share_link
    link_to_function "share", 
                     "var e = document.getElementById('sharelink');
                      if(e.style.display == 'none')
                        e.style.display = 'block';
                      else
                        e.style.display = 'none';" 
  end
  
  def reddit_show_link
    link_to "http://www.stumweb.com/reddits/#{@redditID}-#{@redditTitle}", reddit_path(@redditRecord), target: '_blank'
  end
  
  def imgur_show_link
    link_to "http://www.stumweb.com/imgurs/#{@imgurID}-#{@imgurTitle}", imgur_path(@imgurRecord), target: '_blank'
  end
  
  def title
    # base_title = "Stumweb - Discover some of the best comments on the internet daily"
    base_title = "Stumweb - Discover and share comments"
    if @pageTitle.nil?
      base_title
    else
      "#{@pageTitle} | Stumweb"
    end
  end
  
  def shareReddit
  	link_to image_tag("/assets/FB15.png"), "http://www.facebook.com/sharer.php?u=http://www.stumweb.com/reddits/#{@redditID}-#{@redditTitle}", class: "shareIcon floatLeft", target: "_blank"  
  	link_to "Share", "http://www.facebook.com/sharer.php?u=http://www.stumweb.com/reddits/#{@redditID}-#{@redditTitle}", class: "shareText floatLeft", target: "_blank"  
  	link_to image_tag("/assets/twitter15.png"), "https://twitter.com/intent/tweet?text=#{@title}&url=http://www.stumweb.com/reddits/#{@redditID}-#{@redditTitle}", class: "shareIcon floatLeft shareLeft", target: "_blank"  
  	link_to "Tweet", "https://twitter.com/intent/tweet?text=#{@title}&url=http://www.stumweb.com/reddits/#{@redditID}-#{@redditTitle}", class: "shareText floatLeft", target: "_blank" 
  	link_to image_tag("/assets/G20.png"), "https://plus.google.com/share?url=http://www.stumweb.com/reddits/#{@redditID}-#{@redditTitle}", class: "shareIcon floatLeft shareLeft", target: "_blank" 
  	link_to image_tag("/assets/L20.png"), "http://www.linkedin.com/shareArticle?url=http://www.stumweb.com/reddits/#{@redditID}-#{@redditTitle}&title=#{@title}", class: "shareIcon floatLeft shareLeft2", target: "_blank"  
  	link_to image_tag("/assets/Email33.png"), "mailto:?subject=#{@title}&body=Hey, check out this awesome comment:  http://www.stumweb.com/reddits/#{@redditID}-#{@redditTitle}", class: "shareIcon floatLeft shareLeft3 email", target: "_blank" 
  end
end
