class Views::Shared::Title < Views::Base
  needs :name
  needs :path

  def content
    link_to name, path, class: 'title'
  end
end

