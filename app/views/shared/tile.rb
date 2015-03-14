class Views::Shared::Tile < Views::Base
  needs :object
  needs :metadata
  needs :title_widget

  def content
    div class: 'tile' do
      widget title_widget
      link_to "by #{object.user.login}", object.user, class: 'author'
      div truncate(object.description, length:100), class: 'desc'
      div object.created_at.strftime('%D'), class: 'date'
      div metadata, class: 'metadata'
    end
  end
end

