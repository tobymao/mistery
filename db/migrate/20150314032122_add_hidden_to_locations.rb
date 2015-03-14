class AddHiddenToLocations < ActiveRecord::Migration
  TABLE = :locations

  def change
    add_column TABLE, :hidden, :boolean, null: false, default: false
  end
end
