class Views::Plays::Index < Views::Layouts::Page
  needs :user_plays
  needs :plays
  needs :user

  def main
    h1 'Play a Scenario'

    h3 "Active Games"
    user_plays.each do |play|
      if play.active
        div do
          link_to play.scenario.name, play, class: 'mainLink'
        end
      end
    end

    h3 "Start A New Game"
    plays.each do |play|
      unless user_plays.any?{|user_play| user_play.active && (user_play.scenario == play.scenario)}
        form_for play do |f|
          f.hidden_field :scenario_id, value: play.scenario.id
          f.button play.scenario.name, class: 'mainLink'
        end
      end
    end

    h3 "Game History"
    user_plays.each do |play|
      unless play.active
        div do
          link_to play.scenario.name, play_path(play), class: 'mainLink'
          div "Points Earned: #{play.points}"
        end
        br
      end
    end
  end
end
