class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.references :user, index: true, foreign_key: true
      t.references :wiki_entry, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
