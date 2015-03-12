class Views::Shared::Tile < Views::Base
  needs :object
  needs :link

  def content
    div class: 'tile' do
      div object.name
      div "by #{object.user.login}"
      div truncate(object.description)
      div object.created_at.strftime('%D')
      link_to(link) {span class: 'titleSpan'}
    end
  end
end

