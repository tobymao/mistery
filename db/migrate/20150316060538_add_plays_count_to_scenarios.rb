class AddPlaysCountToScenarios < ActiveRecord::Migration
  TABLE = :scenarios

  def up
    add_column TABLE, :plays_count, :integer, null: false, default: 0

    Scenario.reset_column_information

    Scenario.all.each do |scenario|
      scenario.plays_count = scenario.plays.count
      scenario.save
    end
  end

  def down
    remove_column TABLE, :plays_count
  end
end
