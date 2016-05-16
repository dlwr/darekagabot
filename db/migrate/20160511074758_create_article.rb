class CreateArticle < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id, null: true
      t.text :text
    end
  end
end
