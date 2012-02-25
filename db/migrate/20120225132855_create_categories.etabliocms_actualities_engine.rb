class CreateCategories < ActiveRecord::Migration

  def change
    create_table :categories do |t|
      t.string :title, :null => false
      t.string :slug, :null => false
      t.text :text

      t.integer :lft
      t.integer :rgt
      t.integer :parent_id

      t.boolean :visible
      t.string :locale, :null => false

      t.timestamps
    end

  end

end

