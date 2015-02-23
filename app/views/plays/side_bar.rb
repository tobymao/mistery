class Views::Plays::SideBar < Views::Base
  needs :play

  def content
    visited_locations = play.actions.includes(:location).map {|action| action.location}

    html do
      div class: 'sideButton' do
        div 'sideSection' do
          play.scenario.locations.each do |location|
            if visited_locations.include?(location)
              link_to location.name, visit_play_path(play.id, location.id)
            else
              form_tag book_play_path(play) do
                hidden_field_tag :location_id, location.id
                submit_tag location.name
              end
            end
          end
        end

        div 'sideSection' do
          link_to 'Solve Mystery'
        end
      end
    end
  end
end
