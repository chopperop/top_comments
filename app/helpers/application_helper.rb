module ApplicationHelper
  def markdown(text)
    options = [:hard_wrap => true, :filter_html => true, :autolink => true, :no_intra_emphasis => true, :fenced_code_blocks => true, :disable_indented_code_blocks => true, :quote => true, :gh_blockcode => true]
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, *options)
    markdown.render(text).html_safe     
  end
  
  def share_link
    link_to_function "share link", 
                     "var e = document.getElementById('sharelink');
                      if(e.style.display == 'none')
                        e.style.display = 'block';
                      else
                        e.style.display = 'none';" 
  end
end
