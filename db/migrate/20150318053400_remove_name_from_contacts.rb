class RemoveNameFromContacts < ActiveRecord::Migration
  TABLE = :contacts

  def change
    Contact.where(location: nil).each {|contact| contact.destroy}

    remove_column TABLE, :name, :string
    change_column_null TABLE, :location_id, false
  end
end
