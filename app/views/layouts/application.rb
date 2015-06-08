class Views::Layouts::Application < Views::Base
  def content
    html do
      head do
        title "Mistery"
        stylesheet_link_tag 'application', media: 'all'
        javascript_include_tag 'application'
        favicon_link_tag 'favicon.ico'
        csrf_meta_tags
        google_analytics
      end

      flash.each do |name, msg|
        div msg, class: "flash #{name}"
      end

      yield
    end
  end

  def google_analytics
    javascript <<-EOF
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
      ga('create', 'UA-63428200-1', 'auto');
      ga('send', 'pageview');
    EOF
  end
end
