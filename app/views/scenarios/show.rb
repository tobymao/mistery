class Views::Scenarios::Show < Views::Layouts::Page
  needs :scenario
  needs :play
  needs :owner

  def main
    purchased = current_user.purchased?(scenario) if current_user

    h1 scenario.name
    h2 "by #{scenario.user.login}"

    div "Universe: #{scenario.universe.name}"
    div "Par: #{scenario.par}"
    div simple_format scenario.description, class: 'mainText'

    form_for play do |f|
      f.hidden_field :scenario_id, value: scenario.id
      f.button 'Play This Scenario', class: 'mainLink'
    end if scenario.price == 0 || purchased

    form_tag purchase_scenario_path do |f|
      button_tag 'Buy This Scenario', class: 'mainLink'
    end if scenario.price > 0 && !purchased

    if owner
      link_to "Edit Scenario", edit_scenario_path(scenario), class: 'mainLink'
    end
  end
end
