class Views::Layouts::Sidebar < Views::Base
  needs :current_user
  needs :current_path

  def content
    ul do
      li do
        path = (current_user && !current_user.guest) ? user_path(current_user) : new_user_path

        link_to path, class: 'sideLink' do
          image_tag 'side_bar/profile.png', height: '30px'
          span 'MY PROFILE', class: 'sideLinkText'
        end
      end

      li do
        link_to nil, class: 'sideLink' do
          image_tag 'side_bar/store.png', height: '30px'
          span 'STORE', class: 'sideLinkText'
        end
      end

      li do
        link_to nil, class: 'sideLink' do
          image_tag 'side_bar/universes.png', height: '30px'
          span 'UNIVERSES', class: 'sideLinkText'
        end
      end

      li do
        link_to nil, class: 'sideLink' do
          image_tag 'side_bar/scenarios.png', height: '30px'
          span 'SCENARIOS', class: 'sideLinkText'
        end
      end

      li do
        link_to nil, class: 'sideLink' do
          image_tag 'side_bar/library.png', height: '30px'
          span 'MY LIBRARY', class: 'sideLinkText'
        end
      end
    end
  end
end
