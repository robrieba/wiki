class CreateWikiEntries < ActiveRecord::Migration
  def change
    create_table :wiki_entries do |t|
      t.string :title
      t.text :body
      t.boolean :private
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
