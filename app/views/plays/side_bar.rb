class Views::Plays::SideBar < Views::Base
  needs :play

  def content
    groups = Hash.new{|hash, key| hash[key] = []}

    play.scenario.locations.each{|location| groups[location.group] << location}

    visited_locations = play.actions.includes(:location).map {|action| action.location}

    html do
      div class: 'sideSection' do
        groups.each do |group, locations|
          div group, class: 'group'

          locations.each do |location|
            if visited_locations.include?(location)
              link_to location.name, visit_play_path(play.id, location.id), class: 'sideLink visited'
            else
              form_tag book_play_path(play) do
                hidden_field_tag :location_id, location.id
                button_tag location.name, class: 'sideLink'
              end
            end
          end
        end
      end

      div class: 'sideSection' do
        link_to 'Back To Introduction', play_path(play), class: 'sideLink'
        link_to 'Solve Mystery', play_guesses_path(play), class: 'sideLink'
      end
    end
  end
end
