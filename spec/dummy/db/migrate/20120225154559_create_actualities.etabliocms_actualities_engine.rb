# This migration comes from etabliocms_actualities_engine (originally 20120225160655)
class CreateActualities < ActiveRecord::Migration

  def change
    create_table :actualities do |t|
      t.string :slug, :null => false
      t.string :title, :null => false
      t.text :perex
      t.text :text
      t.integer :category_id
      t.datetime :publish_date, :null => false
      t.datetime :unpublish_date, :null => false
      t.string :locale

      t.timestamps
    end
  end

end
