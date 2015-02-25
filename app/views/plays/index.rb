class Views::Plays::Index < Views::Layouts::Page
  needs :active_plays
  needs :plays
  needs :user

  def main
    h1 'Play a Scenario'

    active_plays.each do |play|
      div do
        link_to play.scenario.name, play, class: 'mainLink'
      end
    end

    plays.each do |play|
      form_for play do |f|
        f.hidden_field :scenario_id, value: play.scenario.id
        f.button play.scenario.name, class: 'mainLink'
      end
    end

  end
end
