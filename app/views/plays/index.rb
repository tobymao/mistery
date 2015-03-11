class Views::Plays::Index < Views::Layouts::Page
  needs :active_plays
  needs :finished_plays
  needs :plays
  needs :user

  def main
    h1 'Play a Scenario'

    h3 "Active Games"
    active_plays.each do |play| #variable we are looping through (play)
      div do
        link_to play.scenario.name, play, class: 'mainLink' #class mainlink is CSS
      end
    end

    h3 "Start A New Game"
    plays.each do |play|
      unless active_plays.any? { |activeplay| activeplay.scenario == play.scenario} ## CC - prevents active play from showing
        form_for play do |f|
          f.hidden_field :scenario_id, value: play.scenario.id
          f.button play.scenario.name, class: 'mainLink'
        end
      end
    end

    h3 "Game History"

    finished_plays.each do |play|
      
      div do
        link_to play.scenario.name, play_path(play), class: 'mainLink' #class mainlink is CSS
        div "Points Earned: #{play.points}"
      end
      div br

    end
  end
end
