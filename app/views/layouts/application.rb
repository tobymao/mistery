class Views::Layouts::Application < Views::Base
  def content
    html do
      head do
        title "Sherlock"
        stylesheet_link_tag    'application', media: 'all'
        javascript_include_tag 'application'
        csrf_meta_tags
      end

      flash.each do |name, msg|
        div msg, class: "flash #{name}"
      end

      yield
    end
  end
end
