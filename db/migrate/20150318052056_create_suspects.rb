class CreateSuspects < ActiveRecord::Migration
  def up
    create_table :suspects do |t|
      t.string :name, null: false
      t.references :scenario, null: false

      t.timestamps null: false
    end

    execute "CREATE UNIQUE INDEX index_suspects_on_scenario_id_and_name
                   ON suspects USING btree (scenario_id, lower(name));"


    contact_suspect = {}

    # Migrate existing contacts here.
    Contact.where.not(name: nil).each do |contact|
      suspect = Suspect.new
      suspect.name = contact.name
      suspect.scenario = contact.scenario
      suspect.save
      contact_suspect[contact.id] = suspect
    end

    # Migrate guess contacts to suspects.
    add_column :guesses, :suspect_id, :integer

    Guess.where.not(contact_id: nil).each do |guess|
      guess.suspect = contact_suspect[guess.contact_id]
      guess.save
    end

    remove_column :guesses, :contact_id, :integer

    # Migrate answer contacts to suspects.
    add_column :answers, :suspect_id, :integer

    Answer.where.not(contact_id: nil).each do |answer|
      next if answer.text.present?
      answer.suspect = contact_suspect[answer.contact_id]
      answer.save
    end

    remove_column :answers, :contact_id, :integer
  end

  def down
    add_column :answers, :contact_id, :integer
    remove_column :answers, :suspect_id, :integer

    add_column :guesses, :contact_id, :integer
    remove_column :guesses, :suspect_id, :integer

    drop_table :suspects
  end
end
