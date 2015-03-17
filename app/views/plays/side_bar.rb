class Views::Plays::SideBar < Views::Base
  needs :play
  needs :current_path

  def content
    groups = Hash.new{|hash, key| hash[key] = []}

    ids = play.scenario.contacts.map{|c| c.location_id}.compact

    play.scenario.locations.each do |location|
      groups[location.group] << location if !location.hidden || ids.include?(location.id)
    end

    visited_locations = play.actions.includes(:location).map {|action| action.location}

    html do
      div class: 'sideSection' do
        groups.each do |group, locations|
          div group, class: 'group'

          locations.each do |location|
            if visited_locations.include?(location)
              link(location.name, visit_play_path(play.id, location.id))
            else
              button(location.name, book_play_path(play), :location_id, location.id)
            end
          end
        end
      end

      div class: 'sideSection' do
        link_to 'Back To Introduction', play_path(play), class: 'sideLink'
        button('Solve Mystery', start_play_guesses_path(play))
      end
    end
  end

  def link(text, path)
    classes = ['sideLink', 'visited']
    classes << 'selected' if path == current_path
    link_to text, path, class: classes.join(' ')
  end

  def button(text, path, tag_name=nil, tag_id=nil)
    form_tag path do
      hidden_field_tag tag_name, tag_id if tag_name
      button_tag text, class: 'sideLink'
    end
  end
end
