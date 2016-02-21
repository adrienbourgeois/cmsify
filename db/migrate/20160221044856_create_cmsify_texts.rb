class CreateCmsifyTexts < ActiveRecord::Migration
  def change
    create_table :cmsify_texts do |t|
      t.text :content
      t.integer :owner_id
      t.string :owner_type
      t.string :slug

      t.timestamps null: false
    end
    
    add_index :cmsify_texts, :slug
    add_index :cmsify_texts, :owner_id
    add_index :cmsify_texts, :owner_type
  end
end
