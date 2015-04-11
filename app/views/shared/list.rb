class Views::Shared::List < Views::Base
  needs :object
  needs :metadata
  needs :title_gen

  def content
    div class: 'list' do
      title_gen.call('title')
      link_to "by #{object.user.login}", object.user, class: 'author'
      div truncate(object.description, length:100), class: 'desc'
      div metadata, class: 'metadata'
    end
  end
end