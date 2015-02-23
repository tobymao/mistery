class Views::Plays::Index < Views::Layouts::Page
  needs :active_plays
  needs :plays
  needs :user

  def main
    h1 'Play a Scenario'

    active_plays.each do |play|
      div do
        link_to play.scenario.name, play
      end
    end

    plays.each do |play|
      form_for [user, play] do |f|
        f.label :scenario_id, play.scenario.name
        f.hidden_field :scenario_id, value: play.scenario.id
        f.submit
      end
    end

  end
end
