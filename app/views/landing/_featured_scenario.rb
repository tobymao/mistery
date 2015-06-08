class Views::Landing::FeaturedScenario < Views::Base
  needs :scenario

  def content
    div class: 'featured' do
      div scenario.name, class: 'title'

      div scenario.user.login, class: 'author'

      div class: 'date'

      div class: 'desc' do
      end
    end
  end
end
