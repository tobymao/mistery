class Views::Shared::PlayTitle < Views::Base
  needs :play

  def content
    form_for play do |f|
      f.hidden_field :scenario_id, value: play.scenario.id
      f.button play.scenario.name, class: 'title'
    end
  end
end
