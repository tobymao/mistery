class Views::Shared::Tile < Views::Base
  needs :object
  needs :link

  def content
    div class: 'tile' do
      div object.name, class: 'title'
      div "by #{object.user.login}", class: 'author'
      div truncate(object.description, length:100), class: 'desc'
      div object.created_at.strftime('%D'), class: 'date'
      link_to(link) {span class: 'titleSpan'}
    end
  end
end

